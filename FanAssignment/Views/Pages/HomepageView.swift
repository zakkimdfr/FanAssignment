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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                // Current User Information
                if userViewModel.user != nil {
                    
                    CurrentUserView()
                        .padding(.horizontal)
                    
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 30)
                            
                            TextField("Search by name or email", text: $searchQuery)
                                .padding()
                                .textInputAutocapitalization(.never)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(.systemBrown))
                                .opacity(0.4)
                        )
                        
                        Button(action: {
                            showOnlyVerified.toggle()
                            if showOnlyVerified {
                                userViewModel.fetchUsersByVerificationStatus(isVerified: showOnlyVerified)
                            } else {
                                userViewModel.fetchAllUsers()
                            }
                        }) {
                            Image(systemName: (showOnlyVerified ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle"))
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(showOnlyVerified ? Color(.systemBrown) : Color(.black))
                        }
                    }
                    .padding(.horizontal)
                
                    List(userViewModel.filteredUsers.filter { user in
                        let searchMatch = searchQuery.isEmpty ||
                        user.name.localizedCaseInsensitiveContains(searchQuery) ||
                        user.email.localizedCaseInsensitiveContains(searchQuery)
                        let verifiedMatch = !showOnlyVerified || user.verificationStatus
                        return searchMatch && verifiedMatch
                    }) { user in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                    .foregroundColor(Color(.systemBrown))
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            Spacer()
                            Image(systemName: (user.verificationStatus ? "checkmark.seal.fill" : "xmark.seal.fill"))
                                .foregroundColor(user.verificationStatus ? Color(.systemGreen) : Color(.systemRed))

                        }
                    }
                    
                } else {
                    Text("No user data available.")
                        .foregroundStyle(.brown)
                        .font(.title2)
                        .padding()
                }
                
                
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                if userViewModel.user != nil {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Home")
                            .foregroundColor(Color(.systemBrown))
                            .font(.system(size: 18, weight: .semibold))

                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action:{
                            userViewModel.signOut()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text("Sign Out")
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                            }
                            .foregroundColor(Color(.systemBrown))
                            .font(.system(size: 15, weight: .semibold))
                        }
                    }
                }
            }
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


