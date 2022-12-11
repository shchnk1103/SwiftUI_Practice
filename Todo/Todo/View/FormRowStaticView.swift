//
//  FormRowStaticView.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/11.
//

import SwiftUI

struct FormRowStaticView: View {
    // MARK: - PROPERTY
    var icon: String
    var firstText: String
    var secondText: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText)
                .foregroundColor(.gray)
            Spacer()
            Text(secondText)
        } //: HSTACK
        .padding(.vertical, 3)
    }
}

// MARK: - PREVIEW
struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
            .padding()
    }
}
