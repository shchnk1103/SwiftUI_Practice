//
//  ContentView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var locationManager = LocationManager()
    @ObservedObject private var weatherKitManager = WeatherKitManager()
    @AppStorage("weatherIcon") var weatherIcon: String = "icloud.slash"
    
    @State private var selectedTab: Tab = .home
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            ZStack(alignment: .bottom) {
                Color.clear
                
                switch selectedTab {
                case .home:
                    HomeView()
                case .search:
                    AddView()
                    //  test_2()
                case .me:
                    MeView()
                }
                
                TabBarView(selectedTab: $selectedTab)
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Color.clear.frame(height: 88)
            }
            .onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            }
            .task(id: locationManager.currentLocation) {
                await weatherKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                
                weatherIcon = weatherKitManager.symbol
            }
        } else {
            LaunchScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
        }
    }
}

extension Notification.Name {
    static let didChangeColorScheme = Notification.Name("didChangeColorScheme")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
