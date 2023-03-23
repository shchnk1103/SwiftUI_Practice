//
//  MeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import SwiftUI

struct MeView: View {
    @State private var isDarkMode: Bool = false
    @State private var isDarkModeWithSystem: Bool = true
    
    var body: some View {
        VStack {
            HeaderView()
                .padding(.horizontal, 15)
                .padding(.top, 20)
            
            List {
                Section {
                    Toggle(isOn: $isDarkMode, label: {
                        HStack {
                            Image(systemName: "sun.min.fill")
                                .padding(1)
                            Text("暗黑模式")
                                .foregroundColor(.black)
                        }
                    })
                    .toggleStyle(CustomTopToggleStyle())
                    
                    Toggle(isOn: $isDarkModeWithSystem, label: {
                        HStack {
                            Image(systemName: "iphone")
                                .renderingMode(.original)
                                .padding(1)
                            Text("暗黑模式跟随系统")
                                .foregroundColor(.black)
                        }
                    })
                    .toggleStyle(CustomTopToggleStyle())
                } header: {
                    Text("还没有很多的设置")
                }

            }
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
