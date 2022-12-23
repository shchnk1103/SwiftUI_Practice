//
//  WeatherView.swift
//  Weather
//
//  Created by DoubleShy0N on 2022/12/23.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText: String = ""
    
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { forecast in
                forecast.location.contains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Color.background.ignoresSafeArea()
            
            // MARK: - Weather Widgets
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                Color.clear
                    .frame(height: 110)
            }
        }
        .toolbar(.hidden)
        .overlay {
            // MARK: - Navigation Bar
            NavigationBar(searchText: $searchText)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .preferredColorScheme(.dark)
    }
}
