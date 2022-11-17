//
//  CoverImageView.swift
//  Africa
//
//  Created by 沈晨凯 on 2022/11/11.
//

import SwiftUI

struct CoverImageView: View {
    // MARK: - PROPERTIES
    let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(coverImages) { coverImage in
                Image(coverImage.name)
                    .resizable()
                    .scaledToFill()
            } //: LOOP
        } //: TAB
        .tabViewStyle(.page)
    }
}

// MARK: - PREVIEW
struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
            .frame(height: 300.0)
            .previewLayout(.sizeThatFits)
    }
}
