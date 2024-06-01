//
//  UserViewModelTests.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import XCTest 
@testable import FanAssignment
import FirebaseAuth

class UserViewModelTests: XCTestCase {
    var userViewModel: UserViewModel!
    var mockUserService: MockUserService!
    var mockEmailVerificationService: MockEmailVerificationService!
    var mockFirestoreService: MockFirestoreService!

    override func setUp() {
        super.setUp()
        mockUserService = MockUserService()
        mockEmailVerificationService = MockEmailVerificationService()
        mockFirestoreService = MockFirestoreService()
        userViewModel = UserViewModel(userService: mockUserService, emailVerificationService: mockEmailVerificationService, firestoreService: mockFirestoreService)
    }

    override func tearDown() {
        userViewModel = nil
        mockUserService = nil
        mockEmailVerificationService = nil
        mockFirestoreService = nil
        super.tearDown()
    }

    func testSignUpSuccess() {
        let user = User(uid: "12345", email: "test@example.com", isEmailVerified: false)
        mockUserService.signUpResult = .success(user)

        let expectation = self.expectation(description: "SignUp")

        userViewModel.signUp(name: "Test User", email: "test@example.com", password: "password123")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.userViewModel.isRegistered)
            XCTAssertEqual(self.userViewModel.user?.email, "test@example.com")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSignUpFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sign Up Error"])
        mockUserService.signUpResult = .failure(error)

        let expectation = self.expectation(description: "SignUp")

        userViewModel.signUp(name: "Test User", email: "test@example.com", password: "password123")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.userViewModel.isRegistered)
            XCTAssertEqual(self.userViewModel.errorMessage, "Sign Up Error")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSignInSuccess() {
        let user = User(uid: "12345", email: "test@example.com", isEmailVerified: false)
        mockUserService.signInResult = .success(user)

        let expectation = self.expectation(description: "SignIn")

        userViewModel.signIn(email: "test@example.com", password: "password123")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.userViewModel.isLoggedIn)
            XCTAssertEqual(self.userViewModel.user?.email, "test@example.com")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSignInFailure() {
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sign In Error"])
        mockUserService.signInResult = .failure(error)

        let expectation = self.expectation(description: "SignIn")

        userViewModel.signIn(email: "test@example.com", password: "password123")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.userViewModel.isLoggedIn)
            XCTAssertEqual(self.userViewModel.errorMessage, "Sign In Error")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSignOutSuccess() {
        let expectation = self.expectation(description: "SignOut")

        userViewModel.signOut()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.userViewModel.isLoggedIn)
            XCTAssertNil(self.userViewModel.user)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSendEmailVerification() {
        let expectation = self.expectation(description: "SendEmailVerification")

        userViewModel.sendEmailVerification()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.userViewModel.errorMessage, "Verification email sent.")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}

