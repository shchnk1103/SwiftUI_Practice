//
//  CenterModifier.swift
//  Africa
//
//  Created by 沈晨凯 on 2022/11/17.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
