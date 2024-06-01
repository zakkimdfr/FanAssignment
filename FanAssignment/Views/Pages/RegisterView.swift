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
                    
                    Text("Register")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.bottom)
                    
                    HStack {
                        Text("Name")
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Spacer()
                        TextField("Your Name", text: $name)
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
                    
                    Button(action: {
                        userViewModel.signUp(name: name, email: email, password: password)
                    }, label: {
                        Text("Create Account")
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
            .navigationBarItems(leading: Button(action: {
                // Action for back button
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            })
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
