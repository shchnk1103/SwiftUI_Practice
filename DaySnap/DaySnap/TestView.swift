//
//  TestView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI
import AuthenticationServices

struct TestView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                switch authorization.credential {
                case let credential as ASAuthorizationAppleIDCredential:
                    let userId = credential.user
                    let email = credential.email
                    let firstName = credential.fullName?.givenName
                    let lastName = credential.fullName?.familyName
                    
                    self.userId = userId
                    self.email = email ?? ""
                    self.firstName = firstName ?? ""
                    self.lastName = lastName ?? ""
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        .frame(height: 50)
        .padding()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
