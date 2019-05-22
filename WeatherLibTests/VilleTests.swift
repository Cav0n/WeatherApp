//
//  VilleTests.swift
//  WeatherLibTests
//
//  Created by Richard Bergoin on 10/02/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import XCTest

@testable import WeatherLib

class VilleTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testVilleInitializer_withCorrectLine() {
        // Given
        let line = "CLERMONT FERRAND  ,63000,45.783333,3.083333,0.37"
        
        // When
        let ville = Ville(fromCsvLine: line)
        
        // Expect
        XCTAssertNotNil(ville)
    }
    
    func testVilleInitializer_withEmptyLine() {
        // Given
        
        // When
        
        // Expect
    }
    
    func testVilleInitializer_withNotAllColumnsLine() {
        // Given
        
        // When
        
        // Expect
    }
    
    func testVilleInitializer_withLineHavingInvalidLatitude() {
        // Given
        
        // When
        
        // Expect
    }
    
    func testVilleClermont_shouldGenerateCorrectGoogleMapLink() {
        // Given
        let ville = Ville(nom: "Clermont-Ferrand", codePostal: "63000", latitude: 45.783333, longitude: 3.083333)
        
        // When
        let googleMapsLink = ville.googleMapLink
        
        // Expect
        XCTAssertEqual(googleMapsLink, "https://www.google.com/maps/@45.783333,3.083333,15z")
    }
}
