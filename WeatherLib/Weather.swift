//
//  Weather.swift
//  WeatherLib
//
//  Created by Richard Bergoin on 10/02/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import Foundation

public struct WeatherCurrently: Codable {
    public let summary: String
    public let temperature: Double
    public let icon: String
}

public struct WeatherHourly: Codable{
    public let summary: String
    public let icon: String
    public let data: [WeatherData]
}

public struct WeatherData: Codable{
    public let time: Double
    public let summary: String
    public let icon: String
    public let temperature : Double
}

public struct Weather: Codable {
    public let currently: WeatherCurrently
    public let hourly: WeatherHourly
    
    init?(data: Data?) {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        if let weather = try? decoder.decode(Weather.self, from: data) {
            self = weather
        } else {
            return nil
        }
    }

}
