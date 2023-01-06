//
//  ContentView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/2.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @AppStorage("showModal") var showModal = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                AccountView()
            case .notification:
                AccountView()
            case .library:
                AccountView()
            }
            
            TabBarView()
                .offset(y: model.showDetail ? 200 : 0)
            
            if showModal {
                ZStack {
                    Color.clear
                        .background(.regularMaterial)
                        .ignoresSafeArea()
                    
                    SignUpView()
                    
                    Button {
                        withAnimation {
                            showModal = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.bold())
                            .foregroundStyle(.secondary)
                            .padding(8)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(20)
                }
                .zIndex(1)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 44)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
        
    }
}
