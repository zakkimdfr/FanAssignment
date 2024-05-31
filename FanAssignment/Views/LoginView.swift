//
//  LoginView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("LOGIN")
                    .font(.system(size: 50, weight: .bold))
                    .padding(.bottom)
                
                HStack {
                    Text("Email")
                        .padding(.horizontal)
                    Spacer()
                    TextField("Your Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding(.leading)
                        .frame(width: 235, height: 40)
                        .overlay(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .frame(width: 235, height: 40)
                        }
                }
                .frame(width: 350, height: 50)
                
                HStack {
                    Text("Password")
                        .padding(.horizontal)
                    Spacer()
                    SecureField("Your Password", text: $password)
                        .padding(.leading)
                        .frame(width: 235, height: 40)
                        .overlay(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .frame(width: 235, height: 40)
                        }
                }
                .frame(width: 350, height: 50)
                
                NavigationLink(destination: HomepageView(), isActive: $userViewModel.isLoggedIn) {
                    Button(action: {
                        userViewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 35))
                    })
                    .padding()
                }
                
                HStack {
                    Text("If you don't have account, Sign up")
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("here")
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserViewModel())
}
