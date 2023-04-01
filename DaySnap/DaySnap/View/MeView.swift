//
//  MeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import SwiftUI

struct MeView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var isDarkModeWithSystem: Bool = false
    
    var body: some View {
        List {
            Section {
                HeaderView()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            Section {
                Toggle(isOn: $isDarkMode, label: {
                    HStack {
                        Image(systemName: colorScheme == .dark
                              ? "sun.min.fill"
                              : "moon.fill")
                        .foregroundColor(.primary)
                        .padding(1)
                        Text("暗黑模式")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                })
                .toggleStyle(CustomTopToggleStyle())
                .onChange(of: isDarkMode) { newValue in
                    self.isDarkMode = isDarkMode
                }
                
                //                    Toggle(isOn: $isDarkModeWithSystem, label: {
                //                        HStack {
                //                            Image(systemName: "iphone")
                //                                .renderingMode(.original)
                //                                .foregroundColor(.primary)
                //                                .padding(1)
                //                            Text("暗黑模式跟随系统")
                //                                .foregroundColor(colorScheme == .dark ? .white : .black)
                //                        }
                //                    })
                //                    .toggleStyle(CustomTopToggleStyle())
            } header: {
                Text("还没有很多的设置")
            }
            
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
