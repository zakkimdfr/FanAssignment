//
//  RegisterView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 30/05/24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("REGISTER")
                    .font(.system(size: 50, weight: .bold))
                    .padding(.bottom)
                
                HStack {
                    Text("Name")
                        .padding(.horizontal)
                    Spacer()
                    TextField("Your Name", text: $name)
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
                
                NavigationLink(destination: LoginView(), isActive: $userViewModel.isRegistered) {
                    Button(action: {
                        userViewModel.signUp(name: name, email: email, password: password)
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 35))
                    })
                    .padding(.top)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
        .environmentObject(UserViewModel())
}
