//
//  SettingsView.swift
//  Avocados
//
//  Created by 沈晨凯 on 2022/11/29.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTY
    @State private var enableNotification: Bool = true
    @State private var backgroundRefresh: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: - HEADER
            VStack(alignment: .center, spacing: 5) {
                Image("avocado")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .frame(width: 100, height: 100, alignment: .center)
                    .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 4)
                
                Text("Avocados".uppercased())
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenAdaptive"))
            } //: VSTACK
            .padding()
            
            Form {
                // MARK: - SECTION #1
                Section {
                    Toggle(isOn: $enableNotification) {
                        Text("Enable notification")
                    }
                    
                    Toggle(isOn: $backgroundRefresh) {
                        Text("Background refresh")
                    }
                } header: {
                    Text("General Settings")
                }
                
                // MARK: - SECTION #2
                Section {
                    if enableNotification {
                        HStack {
                          Text("Product").foregroundColor(Color.gray)
                          Spacer()
                          Text("Avocado Recipes")
                        } //: HSTACK
                        HStack {
                          Text("Compatibility").foregroundColor(Color.gray)
                          Spacer()
                          Text("iPhone & iPad")
                        } //: HSTACK
                        HStack {
                          Text("Developer").foregroundColor(Color.gray)
                          Spacer()
                          Text("John / Jane")
                        } //: HSTACK
                        HStack {
                          Text("Designer").foregroundColor(Color.gray)
                          Spacer()
                          Text("Robert Petras")
                        } //: HSTACK
                        HStack {
                          Text("Website").foregroundColor(Color.gray)
                          Spacer()
                          Text("swiftuimasterclass.com")
                        } //: HSTACK
                        HStack {
                          Text("Version").foregroundColor(Color.gray)
                          Spacer()
                          Text("1.0.0")
                        } //: HSTACK
                    } else {
                        HStack {
                            Text("Personal message")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("👍 Happy Coding!")
                        }
                    }
                } header: {
                    Text("Application")
                }

            }
        } //: VSTACK
        .frame(maxWidth: 640)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
