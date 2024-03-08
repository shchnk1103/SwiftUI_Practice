//
//  ColorCustomView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/26.
//

import SwiftUI

struct ColorCustomView: View {
    // All Color
    @AppStorage("colorCustom") var colorCustom: String = ""
    @State private var selectedColor = Color.primary
    // Tab Bar Color
    @AppStorage("colorTabBar") var colorTabBar: String = ""
    @State private var selectedTabBarColor = Color.primary
    // Switch Color
    @AppStorage("colorSwitch") var colorSwitch: String = ""
    @State private var selectedSwitchColor = Color.primary
    // Button Color
    @AppStorage("colorButton") var colorButton: String = ""
    @State private var selectedButtonColor = Color.primary
    
    var body: some View {
        List {
            customAllColor
            
            customTabBarColor
            
            customSwitchColor
            
            customButtonColor
        }
        .navigationTitle("自定义颜色")
        .safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: 88)
        }
    }
    
    var customAllColor: some View {
        Section {            
            VStack(spacing: 12) {
                ColorTitleView(colorCustom: $colorCustom, selectedColor: selectedColor, title: "所有颜色：")
                
                Capsule(style: .continuous)
                    .foregroundColor(stringToColor(color: colorCustom))
                    .padding(.bottom, 4)
            }
        }
    }
    
    var customTabBarColor: some View {
        Section {
            VStack(spacing: 12) {
                ColorTitleView(colorCustom: $colorTabBar, selectedColor: selectedTabBarColor, title: "底部导航栏颜色：")
                
                HStack {
                    TabBarView(selectedTab: .constant(.home))
                        .disabled(true)
                }
                .frame(height: 60)
                .cornerRadius(30)
            }
        }
    }
    
    var customSwitchColor: some View {
        Section {
            VStack(spacing: 12) {
                ColorTitleView(colorCustom: $colorSwitch, selectedColor: selectedSwitchColor, title: "导航栏颜色：")
                
                SwitchView()
                    .disabled(true)
            }
        }
    }
    
    var customButtonColor: some View {
        Section {
            VStack(spacing: 12) {
                ColorTitleView(colorCustom: $colorButton, selectedColor: selectedButtonColor, title: "按钮颜色：")
                
                button
            }
        }
    }
    
    var button: some View {
        Button {} label: {
            HStack {
                Spacer()
                Text("添加")
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.vertical, 12)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .foregroundColor(stringToColor(color: colorButton))
        }
    }
}

struct ColorCustomView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCustomView()
    }
}
