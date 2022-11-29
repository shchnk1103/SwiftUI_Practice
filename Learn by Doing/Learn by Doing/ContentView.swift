//
//  ContentView.swift
//  Learn by Doing
//
//  Created by 沈晨凯 on 2022/11/27.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    var cardDatas: [Card] = cardData
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(cardDatas) { cardData in
                    CardView(cardData: cardData)
                }
            } //: HSTACK
            .padding(20)
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
