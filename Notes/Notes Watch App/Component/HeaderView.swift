//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by 沈晨凯 on 2022/11/27.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTY
    var title: String = ""
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // TITLE
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            
            // SEPARATOR
            HStack(alignment: .center, spacing: 4) {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            } //: HSTACK
            .foregroundColor(.accentColor)
        } //: VSTACK
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView()
            HeaderView(title: "Credits")
        }
    }
}
