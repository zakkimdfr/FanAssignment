//
//  LoginView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundColor1()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                        .frame(height: 300)
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "mail@example.com")
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    
                    NavigationLink(destination:
                                    ForgotView()
                        .navigationBarBackButtonHidden()
                    ) {
                        Text("Forgot password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBrown))
                            .padding(.top, 20)
                            .padding(.bottom, -20)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 10, alignment: .trailing)
                    }
                    
                    HStack {
                        NavigationLink(destination:
                                        HomepageView()
                            .navigationBarBackButtonHidden()
                                       , isActive: $userViewModel.isLoggedIn) {
                            Button(action: {
                                userViewModel.signIn(email: email, password: password)
                            }, label: {
                                HStack {
                                    Text("SIGN IN")
                                    Image(systemName: "arrow.right")
                                }
                            })
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                    .foregroundColor(Color(.systemBrown))
                            )
                        }
                                       .disabled(!formIsValid)
                                       .opacity(formIsValid ? 1.0 : 0.5)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.vertical, 50)
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have an account? |")
                        
                        NavigationLink(destination:
                                        RegisterView()
                            .navigationBarBackButtonHidden()
                        ) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                        }
                    }
                    .font(.callout)
                    .foregroundColor(.brown)
                }
                .padding(.horizontal)
                .padding(.top, 24)
            }
            .onAppear() {
                email = ""
                password = ""
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserViewModel(
            userService: AuthManager.shared,
            emailVerificationService: AuthManager.shared,
            firestoreService: FirestoreManager.shared
        ))
}

extension LoginView: AuthForm {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct BackgroundColor1: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.brown)
                .position(CGPoint(x: 10.0, y: 10.0))
            
            LogoView()
                .position(CGPoint(x: UIScreen.main.bounds.width - 200,
                                  y: UIScreen.main.bounds.height - 600))
        }
    }
}

struct BackgroundColor2: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.brown)
                .position(CGPoint(x: 10.0, y: 10.0))
        }
    }
}

struct LogoView: View {
    var body: some View {
        Image(systemName: "swift")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 120)
            .foregroundColor(Color(.systemBrown))
            .background(
                Circle()
                    .foregroundColor(.brown)
                    .frame(width: 150, height: 150)
                    .opacity(0.3)
            )
            .padding(.vertical, 50)
            .padding(.top, 50)
    }
}
