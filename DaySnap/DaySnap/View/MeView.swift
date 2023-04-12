//
//  MeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import SwiftUI

enum DisplayMode: Int {
    case system = 0
    case dark = 1
    case light = 2
}

struct MeView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("displayMode") var displayMode: DisplayMode = .system
    @AppStorage("isDarkModeWithSystem") private var isDarkModeWithSystem: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Image("light")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(width: 80, height: 200)
                            
                            Image(systemName: colorScheme == .dark ? "circle" : "checkmark.circle")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .padding(.horizontal)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .strokeStyle(cornerRadius: 12)
                        .onTapGesture {
                            displayMode = .light
                            overrideDisplayMode()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image("dark")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(width: 80, height: 200)
                            
                            Image(systemName: colorScheme == .dark ? "checkmark.circle" : "circle")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .padding(.horizontal)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .strokeStyle(cornerRadius: 12)
                        .onTapGesture {
                            displayMode = .dark
                            overrideDisplayMode()
                        }
                        
                        Spacer()
                    }
                    .animation(.default, value: displayMode)
                    
                    Toggle(isOn: $isDarkModeWithSystem.animation(), label: {
                        Text("自动")
                    })
                    .toggleStyle(CustomTopToggleStyle())
                    .onChange(of: isDarkModeWithSystem) { newValue in
                        if newValue == true {
                            displayMode = .system
                        }
                        overrideDisplayMode()
                    }
                } header: {
                    Text("暗黑模式")
                }
            }
            .navigationTitle("设置")
        }
    }
    
    // MARK: functions
    func overrideDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle
        
        switch displayMode {
        case .system:
            userInterfaceStyle = UITraitCollection.current.userInterfaceStyle
        case .dark:
            userInterfaceStyle = .dark
        case .light:
            userInterfaceStyle = .light
        }
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.overrideUserInterfaceStyle = userInterfaceStyle
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
