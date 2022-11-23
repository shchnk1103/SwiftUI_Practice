//
//  CategoryGridView.swift
//  Touchdown
//
//  Created by 沈晨凯 on 2022/11/23.
//

import SwiftUI

struct CategoryGridView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: gridLayout,
                alignment: .center,
                spacing: columnSpacing,
                pinnedViews: []
            ) {
                Section {
                    ForEach(categories) { category in
                        CategoryItemView(category: category)
                    } //: LOOP
                } header: {
                    SectionView(rotateClockwise: false)
                } footer: {
                    SectionView(rotateClockwise: true)
                } //: SECTION
            } //: GRID
            .frame(height: 140)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        } //: SCROLL
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
    }
}
