//
//  WeatherKitManager.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/10.
//

import Foundation
import WeatherKit
import CoreLocation

@MainActor class WeatherKitManager: ObservableObject {
    @Published var weather: Weather?
    
    func getWeather(latitude: Double, longitude: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated, operation: {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }).value
        } catch {
            print("\(error)")
        }
    }
    
    var symbol: String {
        weather?.currentWeather.symbolName ?? "icloud.slash"
    }
    
    var temp: String {
        let temp = weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .celsius).description
        return convert ?? "Loading Weather Data"
    }
}
