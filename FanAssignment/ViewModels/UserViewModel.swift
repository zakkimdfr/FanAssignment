//
//  UserViewModel.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoggedIn: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String?

    private var db = Firestore.firestore()
    

    // Fungsi untuk sign up
    func signUp(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isRegistered = false
                return
            }

            guard let firebaseUser = authResult?.user else { return }
            self.user = UserModel(uid: firebaseUser.uid, name: name, email: email, password: password, verificationStatus: firebaseUser.isEmailVerified)
            self.isRegistered = true
            self.saveToFirebase()
            self.sendEmailVerification()
        }
    }

    // Fungsi untuk sign in
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isLoggedIn = false
                return
            }

            guard let firebaseUser = authResult?.user else { return }
            self.user = UserModel(uid: firebaseUser.uid, name: "", email: email, password: password, verificationStatus: firebaseUser.isEmailVerified)
            self.isLoggedIn = true
            self.fetchUserDetails()
        }
    }

    // Fungsi untuk menyimpan data pengguna ke Firebase Firestore
    func saveToFirebase() {
        guard let user = user else { return }
        do {
            try db.collection("users").document(user.uid).setData(from: user)
        } catch let error {
            self.errorMessage = error.localizedDescription
        }
    }

    // Fungsi untuk mengirim email verifikasi
    func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = "Verification email sent."
            }
        }
    }

    // Fungsi untuk mengambil detail pengguna dari Firestore
    func fetchUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.user = try document.data(as: UserModel.self)
                } catch let error {
                    self.errorMessage = error.localizedDescription
                }
            } else {
                self.errorMessage = error?.localizedDescription ?? "User does not exist."
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isLoggedIn = false
        } catch let error {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func updateVerificationStatus(uid: String, isVerified: Bool) {
        let userRef = db.collection("users").document(uid)
        userRef.updateData(["verificationStatus": isVerified]) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.fetchUserDetails()
            }
        }
    }
    
    func refreshVerificationStatus() {
        guard let user = self.user else { return }
        if let firebaseUser = Auth.auth().currentUser, firebaseUser.uid == user.uid {
            let isVerified = firebaseUser.isEmailVerified
            if user.verificationStatus != isVerified {
                self.updateVerificationStatus(uid: user.uid, isVerified: isVerified)
            }
        }
    }
}
