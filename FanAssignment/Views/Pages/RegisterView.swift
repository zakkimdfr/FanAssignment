//
//  RegisterView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

// RegisterView.swift
// FanAssignment

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundColor1()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                InputView(text: $name,
                          title: "Name",
                          placeholder: "Enter your Name")
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "mail@example.com")
                
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Confirm your password",
                          isSecureField: true)
                
                HStack {
                    Button(action: {
                        userViewModel.signUp(name: name, email: email, password: password)
                        self.dismiss()
                    }, label: {
                        Text("SIGN UP")
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
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                

                
                HStack {
                    Text("Already have an account? |")
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Sign In")
                            .fontWeight(.bold)
                    }

                        
                }
                .font(.callout)
                .foregroundColor(.brown)
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(UserViewModel(
            userService: AuthManager.shared,
            emailVerificationService: AuthManager.shared,
            firestoreService: FirestoreManager.shared
        ))
}

extension RegisterView: AuthForm {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !name.isEmpty
        && password == confirmPassword
    }
}
