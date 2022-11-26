//
//  BlankView.swift
//  Devote
//
//  Created by 沈晨凯 on 2022/11/25.
//

import SwiftUI

struct BlankView: View {
    // MARK: - PROPERTY
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background {
            backgroundColor.opacity(backgroundOpacity)
        }
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
            .background {
                BackgroundImageView()
            }
            .background {
                backgroundGradient.ignoresSafeArea(.all)
            }
    }
}
