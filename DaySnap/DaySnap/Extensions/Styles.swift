//
//  Styles.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import Foundation
import SwiftUI

struct CustomTopToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Button {
                withAnimation(.default) {
                    configuration.isOn.toggle()
                }
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(configuration.isOn ? .gray : .white)
                    .frame(width: 32, height: 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.25), lineWidth: 1)
                    )
                    .overlay(
                        HStack {
                            if configuration.isOn {
                                Spacer()
                            }
                            Circle()
                                .fill(Color.black)
                            if !configuration.isOn {
                                Spacer()
                            }
                        }
                    )
                    .padding(2)
            }
        }
    }
}
