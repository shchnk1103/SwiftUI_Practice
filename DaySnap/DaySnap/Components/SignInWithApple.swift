//
//  TestView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/14.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    @AppStorage("isLogin") var isLogin: Bool = false
    @AppStorage("identityToken") var identityToken: Data?
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                switch authorization.credential {
                case let credential as ASAuthorizationAppleIDCredential:
                    if let email = credential.email,
                       let fullNmae = credential.fullName {
                        let userId = credential.user
                        let identityToken = credential.identityToken
                        
                        self.userId = userId
                        self.email = email
                        self.firstName = fullNmae.familyName ?? ""
                        self.lastName = fullNmae.givenName ?? ""
                        self.isLogin = true
                        self.identityToken = identityToken
                    } else {
                        self.isLogin = true
                    }
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        .frame(height: 50)
    }
}

struct SignInWithAppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButtonView()
    }
}
