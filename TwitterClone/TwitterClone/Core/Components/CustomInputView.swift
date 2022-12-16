//
//  CustomInputView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/16.
//

import SwiftUI

struct CustomInputView: View {
    let imageName: String
    let placeholderText: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                TextField(placeholderText, text: $text)
            }
            
            Divider()
                .background {
                    Color(.darkGray)
                }
        }
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(imageName: "envelope", placeholderText: "email", text: .constant(""))
    }
}
