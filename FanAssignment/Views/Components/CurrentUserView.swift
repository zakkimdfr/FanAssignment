//
//  CurrentUserView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 01/06/24.
//

import SwiftUI

struct CurrentUserView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var name: String = "Zakki Mudhoffar"
    @State private var email: String = "zakki.mudhoffar@gmail.com"
    
    var body: some View {
        if let user = userViewModel.user  {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color(.systemBrown))
                    .frame(height: 120)
                
                HStack(spacing: 15) {
                    Text(getInitials(from: user.name))
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title)
                            .fontWeight(.semibold)
                        Text(user.email)
                            .font(.footnote)
                    }
                    .foregroundColor(.white)
                    
                    
                    VStack {
                        Image(systemName: (user.verificationStatus ? "checkmark.seal.fill" : "xmark.seal.fill"))
                            .foregroundColor(user.verificationStatus ? Color(.systemGreen) : Color(.systemRed))
                        
                        Text("\(user.verificationStatus ? "Verified" : "Not Verified")")
                            .foregroundColor(user.verificationStatus ? Color(.systemGreen) : Color(.systemRed))
                            .font(.caption)
                    }
                }
            }
        } else {
            Text("No user data available.")
                .font(.title2)
                .padding()
        }
    }
}

#Preview {
    CurrentUserView()
        .environmentObject(UserViewModel(
            userService: AuthManager.shared,
            emailVerificationService: AuthManager.shared,
            firestoreService: FirestoreManager.shared
        ))
}

func getInitials(from name: String) -> String {
    let words = name.split(separator: " ")
    let initials = words.reduce("") { (result, word) in
        guard let firstCharacter = word.first else { return result }
        return result + String(firstCharacter)
    }
    return initials
}
