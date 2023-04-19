//
//  MeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/12.
//

import SwiftUI
import UIKit
import RevenueCat

enum DisplayMode: Int {
    case system = 0
    case dark = 1
    case light = 2
}

struct MeView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userViewModel: UserViewModel
    @AppStorage("displayMode") var displayMode: DisplayMode = .system
    @AppStorage("isDarkModeWithSystem") private var isDarkModeWithSystem: Bool = true
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                // 用户
                Section {
                    if userId.isEmpty {
                        SignInWithAppleButtonView()
                    } else {
                        NavigationLink {
                            UserEditView()
                        } label: {
                            HStack(spacing: 0) {
                                Text("欢迎你！ ")
                                
                                (
                                    Text(firstName) + Text(lastName)
                                )
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                        }
                        
                        if !userViewModel.isSubscriptionActive {
                            NavigationLink {
                                PayWallView()
                            } label: {
                                HStack {
                                    Spacer()
                                    Image(systemName: "laurel.leading")
                                    Text("获取高级版")
                                    Image(systemName: "laurel.trailing")
                                    Spacer()
                                }
                                .fontWeight(.semibold)
                                .foregroundColor(.pink)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .strokeStyle(cornerRadius: 8)
                            }
                        }
                    }
                }

                // 暗黑模式
                Section {
                    darkmode
                    
                    darkmodeWithSystemToggle
                }
                
                // 分类管理
                Section {
                    NavigationLink {
                        CategoryManageView()
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.rectangle.portrait")
                            Text("分类管理")
                                .font(.subheadline)
                        }
                    }
                }
                
                // 关于
                Section {
                    Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                        HStack {
                            Image(systemName: "doc.fill")
                            Text("用户许可协议")
                                .font(.subheadline)
                        }
                    }
                    
                    Link(destination: URL(string: "https://privacy.1ts.fun/product/2304110EYdpR9DZr9HoM")!) {
                        HStack {
                            Image(systemName: "newspaper.fill")
                            Text("隐私政策")
                                .font(.subheadline)
                        }
                    }
                    
                    Link(destination:
                            URL(string: "mailto:doubleshy0n@qq.com?subject=DaySnap%20\(UIDevice.current.systemVersion)")!
                    ) {
                        HStack {
                            Image(systemName: "envelope")
                            Text("联系我们")
                                .font(.subheadline)
                        }
                    }
                    
                    Link(destination: URL(string: "https://weibo.com/u/3148371744")!) {
                        HStack {
                            Image(systemName: "hammer.fill")
                            Text("作者 DoubleShy0N")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("设置")
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: 88)
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    var darkmode: some View {
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
    }
    
    var darkmodeWithSystemToggle: some View {
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
