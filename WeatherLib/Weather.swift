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
}

public struct Weather: Codable {
    public let currently: WeatherCurrently
    
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
