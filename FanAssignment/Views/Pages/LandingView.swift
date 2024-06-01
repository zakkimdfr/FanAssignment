//
//  LandingView.swift
//  FanAssignment
//
//  Created by Zakki Mudhoffar on 31/05/24.
//

import SwiftUI

struct LandingView: View {
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
                    
                    Text("Welcome!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log into account")
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
                        
                        .padding(50)
                    }
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Create new account")
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
                    }
                }
            }
        }
    }
}

#Preview {
    LandingView()
}

struct ExtractedView: View {
    var body: some View {
        LinearGradient(colors: [.color1, .color2, .color3], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}
