//
//  UserEditView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/13.
//

import SwiftUI

struct UserEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("姓：")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(firstName)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                HStack {
                    Text("名：")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(lastName)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            
            HStack {
                Text("邮箱：")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(email)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            //            Button {
            //                userId = ""
            //
            //                dismiss()
            //            } label: {
            //                Text("退出登录")
            //                    .fontWeight(.semibold)
            //                    .foregroundColor(.red)
            //                    .padding(.vertical)
            //                    .frame(maxWidth: .infinity)
            //                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            //            }
            //            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle("用户")
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditView()
    }
}
