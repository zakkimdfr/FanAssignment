//
//  UserSearchView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import SwiftUI

struct UserSearchView: View {
    @StateObject var viewModel: UserViewModel
    @State private var searchQuery: String = ""

    var body: some View {
        VStack {
            TextField("Search by name or email", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                viewModel.searchUsers(query: searchQuery)
            }) {
                Text("Search")
            }
            .padding()

            List(viewModel.searchedUsers) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .navigationTitle("User Search")
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView(viewModel: UserViewModel(
            userService: AuthManager.shared,
            emailVerificationService: AuthManager.shared,
            firestoreService: FirestoreManager.shared
        ))
    }
}
