//
//  ForgotView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 31/05/24.
//

import SwiftUI

struct ForgotView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            BackgroundColor2()
            VStack {
                InputView(text: $email, title: "Email Address", placeholder: "Enter your email")
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                HStack {
                    Button(action: {
                        userViewModel.resetPassword(email: email)
                    }, label: {
                        Text("RESET PASSWORD")
                        Image(systemName: "arrow.right")
                        
                    })
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                            .foregroundColor(Color(.systemBrown))
                    )
                }
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
                .padding(.vertical, 50)

            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
        
    }
}

#Preview {
    ForgotView()
        .environmentObject(UserViewModel(userService: AuthManager.shared,
                                         emailVerificationService: AuthManager.shared,
                                         firestoreService: FirestoreManager.shared))
}
