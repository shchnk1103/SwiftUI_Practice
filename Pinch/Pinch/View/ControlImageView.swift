//
//  ControlImageView.swift
//  Pinch
//
//  Created by 沈晨凯 on 2022/11/8.
//

import SwiftUI

struct ControlImageView: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .padding(.all)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
