//
//  LoginView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/16.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        // parent container
        VStack {
            
            // header view
            AuthHeaderView(title1: "Hello.", title2: "Welcome back.")
            
            VStack(spacing: 40) {
                CustomInputView(imageName: "envelope", placeholderText: "Email", text: $email)
                
                CustomInputView(imageName: "lock", placeholderText: "Password", text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("Forget")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            
            Button {
                print("Sign In")
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background {
                        Capsule()
                            .fill(Color(.systemBlue))
                    }
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                
                NavigationLink {
                    RegisterationView()
                        .toolbar(.hidden)
                } label: {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .font(.footnote)
            .foregroundColor(Color(.systemBlue))
        }
        .ignoresSafeArea()
        .toolbar(.hidden)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
