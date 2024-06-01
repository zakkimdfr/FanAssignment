//
//  MockService.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import XCTest
@testable import FanAssignment
import FirebaseAuth

class MockUserService: UserService {
    var signUpResult: Result<User, Error>?
    var signInResult: Result<User, Error>?
    var signOutError: Error?
    var resetPasswordError: Error?
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let result = signUpResult {
            completion(result)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let result = signInResult {
            completion(result)
        }
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        completion(signOutError)
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        completion(resetPasswordError)
    }
}

class MockEmailVerificationService: EmailVerificationService {
    //    var sendEmailVerificationError: Error?
    
    func sendEmailVerification(completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
}

class MockFirestoreService: FirestoreService {
    var saveUserError: Error?
    var fetchUserResult: Result<UserModel, Error>?
    var updateVerificationStatusError: Error?
    var fetchUsersByVerificationStatusResult: Result<[UserModel], Error>?
    var searchUsersResult: Result<[UserModel], Error>?
    var fetchAllUsersResult: Result<[UserModel], Error>?
    
    func saveUser(user: UserModel, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func fetchUser(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let user = UserModel(uid: uid, name: "Test User", email: "test@example.com", password: "password123", verificationStatus: false)
        completion(.success(user))
    }
    
    func updateVerificationStatus(uid: String, isVerified: Bool, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func fetchUsersByVerificationStatus(isVerified: Bool, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let users = [UserModel(uid: "12345", name: "Test User", email: "test@example.com", password: "password123", verificationStatus: isVerified)]
        completion(.success(users))
    }
    
    func searchUsers(query: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let users = [UserModel(uid: "12345", name: "Test User", email: "test@example.com", password: "password123", verificationStatus: false)]
        completion(.success(users))
    }
    
    func fetchAllUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        if let result = fetchAllUsersResult {
            completion(result)
        }
    }
}
