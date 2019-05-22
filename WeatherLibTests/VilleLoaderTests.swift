//
//  VilleLoaderTests.swift
//  WeatherLibTests
//
//  Created by Richard Bergoin on 10/02/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import XCTest

@testable import WeatherLib

class VilleLoaderTests: XCTestCase {
    
    func testLoadVille_shouldErrorNoFile() {
        // Given
        let path = "/tmp/not-exisiting.csv"
        
        // When
        let villeLoader = VilleLoader()
        
        // Expect
        XCTAssertThrowsError(try villeLoader.loadVilles(path: path))
    }

    func testLoadVille_shouldLoad10Villes() {
        // Given
        let path = Bundle(for: WeatherTests.self).path(forResource: "ville-10", ofType: "csv")!
        
        // When
        let villeLoader = VilleLoader()
        try! villeLoader.loadVilles(path: path)
        
        // Expect
        XCTAssertEqual(villeLoader.villesByCodePostal.count, 10)
    }
}
