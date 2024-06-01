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
    
    var body: some View {
        NavigationView {
            ZStack {
                ExtractedView()
                VStack {
                    Image(systemName: "swift")
                        .resizable()
                        .frame(width: 120, height: 100)
                        .foregroundColor(.orange)
                        .padding(.bottom)
                    
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.bottom)
                    
                    HStack {
                        Text("Email")
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        Spacer()
                        TextField("Your Email", text: $email)
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .padding(.leading)
                            .frame(width: 235, height: 40)
                            .overlay(alignment: .center) {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 1)
                                    .frame(width: 235, height: 40)
                            }
                    }
                    .frame(width: 350, height: 50)
                    
                    HStack {
                        Text("Password")
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Spacer()
                        SecureField("Your Password", text: $password)
                            .foregroundColor(.white)
                            .padding(.leading)
                            .frame(width: 235, height: 40)
                            .overlay(alignment: .center) {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 1)
                                    .frame(width: 235, height: 40)
                            }
                    }
                    .frame(width: 350, height: 50)
                    
                    NavigationLink(destination: ForgotView()) {
                        Text("Forgot password?")
                            .foregroundStyle(.white)
                    }
                    
                    NavigationLink(destination: HomepageView(), isActive: $userViewModel.isLoggedIn) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        userViewModel.signIn(email: email, password: password)
                        userViewModel.refreshVerificationStatus()
                    }, label: {
                        Text("Sign In")
                            .font(.title2)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .frame(width: 250, height: 50)
                                    .opacity(0.15)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.gray, lineWidth: 3)
                                    })
                            )
                            .padding(.top)
                    })
                    .padding()
                    
                    if let errorMessage = userViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
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
