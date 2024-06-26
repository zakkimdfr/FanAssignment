//
//  ContentView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        if userViewModel.userSession != nil {
            HomepageView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserViewModel(
                    userService: AuthManager.shared,
                    emailVerificationService: AuthManager.shared,
                    firestoreService: FirestoreManager.shared
                ))
}
