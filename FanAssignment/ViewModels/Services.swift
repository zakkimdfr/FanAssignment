//
//  Services.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserService {
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
    func resetPassword(email: String, completion: @escaping (Error?) -> Void)
}

protocol EmailVerificationService {
    func sendEmailVerification(completion: @escaping (Error?) -> Void)
}

protocol FirestoreService {
    func saveUser(user: UserModel, completion: @escaping (Error?) -> Void)
    func fetchUser(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void)
    func updateVerificationStatus(uid: String, isVerified: Bool, completion: @escaping (Error?) -> Void)
    func fetchUsersByVerificationStatus(isVerified: Bool, completion: @escaping (Result<[UserModel], Error>) -> Void)
    func searchUsers(query: String, completion: @escaping (Result<[UserModel], Error>) -> Void)
}




