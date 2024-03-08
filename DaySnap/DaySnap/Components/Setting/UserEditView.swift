//
//  UserEditView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/13.
//

import SwiftUI
import RevenueCat
import AuthenticationServices

struct UserEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userViewModel: UserViewModel
    // User
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    @State private var newFirstName: String = ""
    @State private var newLastName: String = ""
    @State private var newEmail: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    HStack {
                        Text("姓：")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        TextField("", text: $newFirstName)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    
                    HStack {
                        Text("名：")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        TextField("", text: $newLastName)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                
                HStack {
                    Text("邮箱：")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    TextField("", text: $newEmail)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                Button {
                    firstName = newFirstName
                    lastName = newLastName
                    email = newEmail
                    
                    if userId.isEmpty {
                        userId = UUID().uuidString
                    }
                    
                    dismiss()
                } label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .frame(height: 52)
                            .strokeStyle(cornerRadius: 8)
                            .buttonBackgroundColor()
                        
                        Text("保存")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .black.opacity(0.8) : .white)
                    }
                }
                .padding(.top)
                
                Button {
                    Purchases.shared.restorePurchases { customerInfo, error in
                        userViewModel.isSubscriptionActive = customerInfo?.entitlements.all["pro"]?.isActive == true
                        
                        if userViewModel.isSubscriptionActive {
                            let alert = UIAlertController(title: "购买恢复成功", message: "您的订阅已恢复", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "知道了", style: .default))
                            // present the alert
                            DispatchQueue.main.async {
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    let window = UIWindow(windowScene: windowScene)
                                    window.rootViewController?.present(alert, animated: true)
                                }
                            }
                        }
                    }
                } label: {
                    Text("恢复购买")
                        .foregroundColor(.pink)
                }
                .padding(.vertical)
                
                //                Button {
                //                    isLogin = false
                //
                //                    dismiss()
                //                } label: {
                //                    Text("退出登录")
                //                        .fontWeight(.semibold)
                //                        .foregroundColor(.red)
                //                        .padding(.vertical)
                //                        .frame(maxWidth: .infinity)
                //                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                //                }
                //                .padding(.bottom)
                
                Image("astronaut")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
            .padding()
            .navigationTitle("用户")
            .onAppear {
                self.newFirstName = firstName
                self.newLastName = lastName
            }
        }
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditView()
    }
}
