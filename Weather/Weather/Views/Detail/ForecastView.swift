//
//  ForecastView.swift
//  Weather
//
//  Created by DoubleShy0N on 2022/12/19.
//

import SwiftUI

struct ForecastView: View {
    var body: some View {
        ScrollView {
            
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background {
            Color.bottomSheetBackground
        }
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .overlay {
            // MARK: - Bottom Sheet Separator
            Divider()
                .blendMode(.overlay)
                .background {
                    Color.bottomSheetBorderTop
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: - Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.5))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
            .background {
                Color.background
            }
            .preferredColorScheme(.dark)
    }
}
