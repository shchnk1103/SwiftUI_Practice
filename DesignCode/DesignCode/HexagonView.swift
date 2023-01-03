//
//  HexagonView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/3.
//

import SwiftUI

struct HexagonView: View {
    var body: some View {
        Canvas { context, size in
            context.draw(Image(systemName: "hexagon.fill"), in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        .frame(width: 200, height: 212)
        .foregroundStyle(.linearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct HexagonView_Previews: PreviewProvider {
    static var previews: some View {
        HexagonView()
    }
}
