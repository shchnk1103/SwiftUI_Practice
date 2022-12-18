//
//  AuthHeaderView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/18.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1: String
    let title2: String
    
    var body: some View {
        // header view
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            
            Text(title1)
            Text(title2)
        }
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, minHeight: 260)
        .padding(.leading)
        .background {
            Color(.systemBlue)
        }
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "Hello.", title2: "Welcome")
    }
}
