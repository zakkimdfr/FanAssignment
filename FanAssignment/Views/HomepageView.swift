//
//  HomepageView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let user = userViewModel.user {
                    Text("Welcome, \(user.name)")
                        .font(.largeTitle)
                        .padding()

                    Text("Email: \(user.email)")
                        .font(.title2)
                        .padding()

                    Text("Verification Status: \(user.verificationStatus ? "Verified" : "Not Verified")")
                        .font(.title2)
                        .padding()
                } else {
                    Text("No user data available.")
                        .font(.title2)
                        .padding()
                }
                
                Button(action: {
                    userViewModel.signOut()
                }) {
                    Text("Sign Out")
                }
            }
            .navigationBarTitle("Home", displayMode: .large)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomepageView()
        .environmentObject(UserViewModel())
}
