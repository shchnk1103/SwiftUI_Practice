//
//  SettingsView.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/11.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTY
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var iconSettings: IconNames
    
    // THEME
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 1
                    Section {
                        Picker(selection: $iconSettings.currentIndex) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack {
                                    Image(
                                        uiImage: UIImage(
                                            named: iconSettings.iconNames[index] ?? "Blue"
                                        ) ?? UIImage()
                                    )
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(8)
                                    
                                    Spacer()
                                        .frame(width: 8)
                                    
                                    Text(iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                } //: HSTACK
                                .padding(3)
                            }
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                    
                                    Image(systemName: "paintbrush")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                        .foregroundColor(.primary)
                                }
                                .frame(width: 44, height: 44)
                                
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            } //: LABEL
                        } //: PICKER
                        .pickerStyle(.navigationLink)
                        .onReceive([iconSettings.currentIndex].publisher.first()) { value in
                            let index = iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success!")
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Choose the app icon")
                    }
                    .padding(.vertical, 3)
                    
                    // MARK: - SECTION 2
                    Section {
                        List {
                            ForEach(themes, id: \.id) { theme in
                                Button {
                                    self.theme.themeSettings = theme.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                } label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(theme.themeColor)
                                        
                                        Text(theme.themeName)
                                    } //: HSTACK
                                } //: BUTTON
                                .accentColor(.primary)
                            } //: LOOP
                        } //: LIST
                    } header: {
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(themes[theme.themeSettings].themeColor)
                        } //: HSTACK
                    }
                    .padding(.vertical, 3)
                    
                    // MARK: - SECTION 3
                    Section {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://google.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://google.com")
                    } header: {
                        Text("Follow us on social media")
                    }
                    .padding(.vertical, 3)

                    
                    // MARK: - SECTION 4
                    Section {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "DoubleShy0N")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "shchk")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    }

                }
                .listStyle(.grouped)
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("Copyright Ⓒ All rights reserved.\nBetter Apps Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //: VSTACK
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            })
            .background {
                Color("ColorBackground")
                    .ignoresSafeArea()
            }
        } //: NAVIGATION
        .accentColor(themes[theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}
