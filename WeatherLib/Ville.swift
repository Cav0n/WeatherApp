//
//  Ville.swift
//  WeatherLib
//
//  Created by Richard Bergoin on 10/02/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import Foundation

public enum VilleCSVColumn: Int, CaseIterable {
    case nom
    case codePostal
    case latitude
    case longitude
}

public struct Ville {
    public let nom: String
    public let codePostal: String
    public let latitude: Double
    public let longitude: Double
    
    public var googleMapLink: String {
        return "https://www.google.com/maps/@\(latitude),\(longitude),15z"
    }
}

public extension Ville {
    init?(fromCsvLine csvLine: String) {
        let columns = csvLine.components(separatedBy: ",")
        guard columns.count >= VilleCSVColumn.allCases.count else {
            return nil
        }
        guard let latitude = Double(columns[VilleCSVColumn.latitude.rawValue]) else {
            return nil
        }
        guard let longitude = Double(columns[VilleCSVColumn.longitude.rawValue]) else {
            return nil
        }
        self.nom = columns[VilleCSVColumn.nom.rawValue]
        self.codePostal = columns[VilleCSVColumn.codePostal.rawValue]
        self.latitude = latitude
        self.longitude = longitude
    }
}
