//
//  InfoRow.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/14.
//

import SwiftUI

struct InfoRow: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(icon: "trash", text: "shsh")
    }
}
