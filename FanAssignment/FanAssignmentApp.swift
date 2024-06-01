//
//  FanAssignmentApp.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI
import Firebase

@main
struct FanAssignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userViewModel = UserViewModel(
        userService: AuthManager.shared,
        emailVerificationService: AuthManager.shared,
        firestoreService: FirestoreManager.shared
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

