//
//  HomepageView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var searchQuery: String = ""
    @State private var showOnlyVerified: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Current User Information
                if let user = userViewModel.user {
                    VStack(alignment: .leading) {
                        Text("Current User")
                            .font(.title)
                            .padding(.bottom, 5)
                        
                        Text("Name: \(user.name)")
                        Text("Email: \(user.email)")
                        Text("Status: \(user.verificationStatus ? "Verified" : "Not Verified")")
                            .foregroundColor(user.verificationStatus ? .green : .red)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding()
                } else {
                    Text("No user data available.")
                        .font(.title2)
                        .padding()
                }
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading)
                        
                        TextField("Search by name or email", text: $searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .textInputAutocapitalization(.never)
                    }
                }
                
                Toggle(isOn: $showOnlyVerified) {
                    Text("Show only verified users")
                }
                .padding()
                .onChange(of: showOnlyVerified) { value in
                    if value {
                        userViewModel.fetchUsersByVerificationStatus(isVerified: value)
                    } else {
                        userViewModel.fetchAllUsers()
                    }
                }
                
                List(userViewModel.filteredUsers.filter { user in
                    let searchMatch = searchQuery.isEmpty ||
                    user.name.localizedCaseInsensitiveContains(searchQuery) ||
                    user.email.localizedCaseInsensitiveContains(searchQuery)
                    let verifiedMatch = !showOnlyVerified || user.verificationStatus
                    return searchMatch && verifiedMatch
                }) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(user.verificationStatus ? "Verified" : "Not Verified")
                            .foregroundColor(user.verificationStatus ? .green : .red)
                    }
                    .padding()
                }
            }
            .navigationTitle("Homepage")
            .onAppear {
                userViewModel.fetchUserDetails()
                userViewModel.fetchAllUsers()
            }
            .refreshable {
                userViewModel.refreshVerificationStatus()
                userViewModel.fetchAllUsers()
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
