//
//  HomepageView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI
import Firebase

struct HomepageView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let user = userViewModel.user {
                        Text("Welcome, \(user.name)")
                            .font(.largeTitle)
                            .padding()
                        
                        Text("Email: \(user.email)")
                            .font(.title2)
                            .padding()
                        
                        HStack {
                            Text("Status:")
                                .font(.title2)
                            
                            Text(user.verificationStatus ? "Verified" : "Not Verified")
                                .foregroundStyle(user.verificationStatus ? .green : .red)
                                .font(.title2)
                                .padding()
                        }
                    } else {
                        Text("No user data available.")
                            .font(.title2)
                            .padding()
                    }
                    
                    Button(action: {
                        userViewModel.signOut()
                    }) {
                        Text("Sign Out")
                            .font(.title2)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                userViewModel.fetchUserDetails()
            }
            .refreshable {
                userViewModel.refreshVerificationStatus()
            }
        }
    }
}

#Preview {
    HomepageView()
        .environmentObject(UserViewModel(
            userService: AuthManager.shared,
            emailVerificationService: AuthManager.shared,
            firestoreService: FirestoreManager.shared
        ))
}
