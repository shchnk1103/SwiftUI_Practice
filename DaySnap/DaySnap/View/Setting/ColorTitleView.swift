//
//  ColorTitleView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/27.
//

import SwiftUI

struct ColorTitleView: View {
    @Binding var colorCustom: String
    @State var selectedColor: Color
    var title: String
    
    var body: some View {
        HStack {
            ColorPicker(title, selection: $selectedColor)
                .onChange(of: selectedColor, perform: { newValue in
                    colorCustom = colorToString(color: newValue)
                })
                .font(.subheadline)
            
            Spacer()
            
            Button {
                colorCustom = ""
                selectedColor = .primary
            } label: {
                HStack {
                    Image(systemName: "goforward")
                        .font(.subheadline)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(.red, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .foregroundColor(.white.opacity(0.8))
                .shadow(radius: 4)
            }
        }
        .onAppear {
            selectedColor = stringToColor(color: colorCustom)
        }
    }
}

struct ColorTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorTitleView(colorCustom: .constant(""), selectedColor: Color.primary, title: "所有颜色：")
    }
}
