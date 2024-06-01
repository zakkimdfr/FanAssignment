//
//  FirestoreManager.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import Foundation
import FirebaseFirestore

class FirestoreManager: FirestoreService {
    static let shared = FirestoreManager()
    private var db = Firestore.firestore()
    
    // Save user to Firestore
    func saveUser(user: UserModel, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection("users").document(user.uid).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    // Fetch user by uid from Firestore
    func fetchUser(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: UserModel.self)
                    completion(.success(user))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User does not exist."])))
            }
        }
    }
    
    // Update verification status of user
    func updateVerificationStatus(uid: String, isVerified: Bool, completion: @escaping (Error?) -> Void) {
        let userRef = db.collection("users").document(uid)
        userRef.updateData(["verificationStatus": isVerified]) { error in
            completion(error)
        }
    }
    
    // Fetch users by verification status
    func fetchUsersByVerificationStatus(isVerified: Bool, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        db.collection("users").whereField("verificationStatus", isEqualTo: isVerified).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No users found."])))
                return
            }
            
            let users = documents.compactMap { document -> UserModel? in
                try? document.data(as: UserModel.self)
            }
            completion(.success(users))
        }
    }
    
    // Search users by name or email
    func searchUsers(query: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        db.collection("users").whereField("name", isGreaterThanOrEqualTo: query).whereField("name", isLessThanOrEqualTo: query + "\u{f8ff}").getDocuments { nameSnapshot, nameError in
            self.db.collection("users").whereField("email", isGreaterThanOrEqualTo: query).whereField("email", isLessThanOrEqualTo: query + "\u{f8ff}").getDocuments { emailSnapshot, emailError in
                
                var users = [UserModel]()
                
                if let nameDocuments = nameSnapshot?.documents {
                    users += nameDocuments.compactMap { document in
                        try? document.data(as: UserModel.self)
                    }
                }
                
                if let emailDocuments = emailSnapshot?.documents {
                    users += emailDocuments.compactMap { document in
                        try? document.data(as: UserModel.self)
                    }
                }
                
                if let nameError = nameError, let emailError = emailError {
                    completion(.failure(nameError.localizedDescription.isEmpty ? emailError : nameError))
                } else {
                    completion(.success(users))
                }
            }
        }
    }
}
