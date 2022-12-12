//
//  GuidComponent.swift
//  Honeymoon
//
//  Created by DoubleShy0N on 2022/12/12.
//

import SwiftUI

struct GuidComponent: View {
    // MARK: - PROPERTY
    var title: String
    var subtitle: String
    var description: String
    var icon: String
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.pink)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Text(subtitle.uppercased())
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                } //: HSATCK
                
                Divider()
                    .padding(.bottom, 4)
                
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            } //: VSTACK
        } //: HSTACK
    }
}

// MARK: - PREVIEW
struct GuidComponent_Previews: PreviewProvider {
    static var previews: some View {
        GuidComponent(title: "Title", subtitle: "Swipe right", description: "This is a placeholder sentence. This is a placeholder sentence. This is a placeholder sentence.", icon: "heart.circle")
            .previewLayout(.sizeThatFits)
    }
}
