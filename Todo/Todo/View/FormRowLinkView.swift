//
//  FormRowLinkView.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/11.
//

import SwiftUI

struct FormRowLinkView: View {
    // MARK: - PROPERTY
    var icon:String
    var color: Color
    var text: String
    var link: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button {
                guard let url = URL(string: link), UIApplication.shared.canOpenURL(url)
                else {
                    return
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }
    }
}

// MARK: - PERVIEW
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://google.com")
            .padding()
    }
}
