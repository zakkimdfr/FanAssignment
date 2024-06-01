//
//  UserViewModel.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class UserViewModel: ObservableObject {
//    @Published var user: UserModel?
//    @Published var isLoggedIn: Bool = false
//    @Published var isRegistered: Bool = false
//    @Published var errorMessage: String?
//    @Published var passwordResetSent: Bool = false
//    @Published var filteredUsers: [UserModel] = []
//    @Published var searchUsers: [UserModel] = []
//
//    private let userService: UserService
//    private let emailVerificationService: EmailVerificationService
//    private let firestoreService: FirestoreService
//
//    init(userService: UserService, emailVerificationService: EmailVerificationService, firestoreService: FirestoreService) {
//        self.userService = userService
//        self.emailVerificationService = emailVerificationService
//        self.firestoreService = firestoreService
//    }
//
//    func signUp(name: String, email: String, password: String) {
//        userService.signUp(email: email, password: password) { result in
//            switch result {
//            case .success(let firebaseUser):
//                self.user = UserModel(uid: firebaseUser.uid, name: name, email: email, password: password, verificationStatus: firebaseUser.isEmailVerified)
//                self.isRegistered = true
//                self.saveToFirebase()
//                self.sendEmailVerification()
//            case .failure(let error):
//                self.errorMessage = error.localizedDescription
//                self.isRegistered = false
//            }
//        }
//    }
//
//    func signIn(email: String, password: String) {
//        userService.signIn(email: email, password: password) { result in
//            switch result {
//            case .success(let firebaseUser):
//                self.user = UserModel(uid: firebaseUser.uid, name: "", email: email, password: password, verificationStatus: firebaseUser.isEmailVerified)
//                self.isLoggedIn = true
//                self.fetchUserDetails()
//            case .failure(let error):
//                self.errorMessage = error.localizedDescription
//                self.isLoggedIn = false
//            }
//        }
//    }
//
//    func signOut() {
//        userService.signOut { error in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//            } else {
//                self.user = nil
//                self.isLoggedIn = false
//            }
//        }
//    }
//
//    func sendEmailVerification() {
//        emailVerificationService.sendEmailVerification { error in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//            } else {
//                self.errorMessage = "Verification email sent."
//            }
//        }
//    }
//
//    func saveToFirebase() {
//        guard let user = user else { return }
//        firestoreService.saveUser(user: user) { error in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//            }
//        }
//    }
//
//    func fetchUserDetails() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        firestoreService.fetchUser(uid: uid) { result in
//            switch result {
//            case .success(let user):
//                self.user = user
//            case .failure(let error):
//                self.errorMessage = error.localizedDescription
//            }
//        }
//    }
//
//    func refreshVerificationStatus() {
//        guard let user = self.user else { return }
//        if let firebaseUser = Auth.auth().currentUser, firebaseUser.uid == user.uid {
//            let isVerified = firebaseUser.isEmailVerified
//            if user.verificationStatus != isVerified {
//                firestoreService.updateVerificationStatus(uid: user.uid, isVerified: isVerified) { error in
//                    if let error = error {
//                        self.errorMessage = error.localizedDescription
//                    } else {
//                        self.fetchUserDetails()
//                    }
//                }
//            }
//        }
//    }
//
//    func resetPassword(email: String) {
//        userService.resetPassword(email: email) { error in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//                self.passwordResetSent = false
//            } else {
//                self.passwordResetSent = true
//                self.errorMessage = "Password reset email sent."
//            }
//        }
//    }
//    
//    func fetchUsersByVerificationStatus(isVerified: Bool) {
//            firestoreService.fetchUsersByVerificationStatus(isVerified: isVerified) { result in
//                switch result {
//                case .success(let users):
//                    self.filteredUsers = users
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//}

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoggedIn: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String?
    @Published var passwordResetSent: Bool = false
    @Published var filteredUsers: [UserModel] = []
    @Published var searchedUsers: [UserModel] = []  // Added property to store searched users

    private let userService: UserService
    private let emailVerificationService: EmailVerificationService
    private let firestoreService: FirestoreService

    init(userService: UserService, emailVerificationService: EmailVerificationService, firestoreService: FirestoreService) {
        self.userService = userService
        self.emailVerificationService = emailVerificationService
        self.firestoreService = firestoreService
    }

    func signUp(name: String, email: String, password: String) {
        userService.signUp(email: email, password: password) { result in
            switch result {
            case .success(let firebaseUser):
                self.user = UserModel(uid: firebaseUser.uid, name: name, email: email, password: password, verificationStatus: firebaseUser.isEmailVerified)
                self.isRegistered = true
                self.saveToFirebase()
                self.sendEmailVerification()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isRegistered = false
            }
        }
    }

    func signIn(email: String, password: String) {
        userService.signIn(email: email, password: password) { result in
            switch result {
            case .success(let firebaseUser):
                self.user = UserModel(uid: firebaseUser.uid, name: "", email: email, password: password, verificationStatus: firebaseUser.isEmailVerified)
                self.isLoggedIn = true
                self.fetchUserDetails()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isLoggedIn = false
            }
        }
    }

    func signOut() {
        userService.signOut { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.user = nil
                self.isLoggedIn = false
            }
        }
    }

    func sendEmailVerification() {
        emailVerificationService.sendEmailVerification { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = "Verification email sent."
            }
        }
    }

    func saveToFirebase() {
        guard let user = user else { return }
        firestoreService.saveUser(user: user) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func fetchUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        firestoreService.fetchUser(uid: uid) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func refreshVerificationStatus() {
        guard let user = self.user else { return }
        if let firebaseUser = Auth.auth().currentUser, firebaseUser.uid == user.uid {
            let isVerified = firebaseUser.isEmailVerified
            if user.verificationStatus != isVerified {
                firestoreService.updateVerificationStatus(uid: user.uid, isVerified: isVerified) { error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    } else {
                        self.fetchUserDetails()
                    }
                }
            }
        }
    }

    func resetPassword(email: String) {
        userService.resetPassword(email: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.passwordResetSent = false
            } else {
                self.passwordResetSent = true
                self.errorMessage = "Password reset email sent."
            }
        }
    }
    
    func fetchUsersByVerificationStatus(isVerified: Bool) {
        firestoreService.fetchUsersByVerificationStatus(isVerified: isVerified) { result in
            switch result {
            case .success(let users):
                self.filteredUsers = users
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    // Add the searchUsers function
    func searchUsers(query: String) {
        firestoreService.searchUsers(query: query) { result in
            switch result {
            case .success(let users):
                self.searchedUsers = users
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

