//
//  SwitchView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct SwitchView: View {
    @AppStorage("flag") var isCountdownButtonClicked: Bool = true
    
    var body: some View {
        HStack(spacing: 10) {
            ButtonView(isButtonClicked: $isCountdownButtonClicked, buttonType: true)
            
            ButtonView(isButtonClicked: $isCountdownButtonClicked, buttonType: false)
        }
        .animation(.default, value: isCountdownButtonClicked)
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView()
    }
}
