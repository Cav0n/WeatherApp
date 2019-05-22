//
//  WeatherTests.swift
//  WeatherLibTests
//
//  Created by Richard Bergoin on 10/02/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import XCTest

@testable import WeatherLib

class WeatherTests: XCTestCase {
    
    func testInitializerFromValidData() {
        // Given
        let url = Bundle(for: WeatherTests.self).url(forResource: "weather-exemple", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        // When
        let weather = Weather(data: data)
        
        // Expect
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.currently.summary, "Windy and Mostly Cloudy")
    }
    
    func testInitializerFromInvalidData() {
        // Given
        let data = Data()
        
        // When
        let weather = Weather(data: data)
        
        // Expect
        XCTAssertNil(weather)
    }
}
