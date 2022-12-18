//
//  RegisterationView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/16.
//

import SwiftUI

struct RegisterationView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var fullname: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // header view
            AuthHeaderView(title1: "Get started.", title2: "Create your account.")
            
            VStack(spacing: 40) {
                CustomInputView(imageName: "envelope", placeholderText: "Email", text: $email)
                
                CustomInputView(imageName: "person", placeholderText: "Username", text: $username)
                
                CustomInputView(imageName: "person", placeholderText: "Full name", text: $fullname)
                
                CustomInputView(imageName: "lock", placeholderText: "Password", text: $password)
            }
            .padding(32)
            
            Button {
                print("Sign Up")
            } label: {
                Text("Sign Up")
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
                Text("Already have an account?")
                
                Button {
                    dismiss()
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
    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}
