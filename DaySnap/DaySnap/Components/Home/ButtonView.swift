//
//  ButtonView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/27.
//

import SwiftUI

struct ButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    // Switch Color
    @AppStorage("colorSwitch") var colorSwitch: String = ""
    
    @FetchRequest(sortDescriptors: []) var countdowns: FetchedResults<CountDown>
    @FetchRequest(sortDescriptors: []) var checkins: FetchedResults<CheckIn>
    
    @Binding var isButtonClicked: Bool
    let buttonType: Bool
    
    var body: some View {
        Button {
            isButtonClicked = buttonType
        } label: {
            HStack {
                Spacer()
                Text("\(buttonType ? countdowns.count : checkins.count)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()
                Text(buttonType ? "倒数日" : "打卡")
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer()
            }
            .foregroundColor(
                buttonType
                ? (isButtonClicked ? .white : .black.opacity(0.5))
                : (isButtonClicked ? .black.opacity(0.5) : .white)
            )
            .padding(.vertical, 8)
        }
        .background(
            buttonType
            ? (isButtonClicked
               ? (colorSwitch == ""
                  ? (colorCustom == "" ? .black : stringToColor(color: colorCustom))
                  : stringToColor(color: colorSwitch))
               : .white.opacity(0.8))
            : (isButtonClicked
               ? .white.opacity(0.8)
               : (colorSwitch == ""
                  ? (colorCustom == "" ? .black : stringToColor(color: colorCustom))
                  : stringToColor(color: colorSwitch)))
        )
        .cornerRadius(8)
        .strokeStyle(cornerRadius: 8)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25), radius: 8, x: 0, y: 0)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(isButtonClicked: .constant(true), buttonType: true)
    }
}
