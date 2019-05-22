//
//  VilleLoader.swift
//  VilleLib
//
//  Created by Richard Bergoin on 09/02/2018.
//  Copyright © 2018 Richard Bergoin. All rights reserved.
//

import Foundation

public enum VilleLoaderError: Error {
    case nofile(path: String)
    case invalidLine(index: Int)
}

public class VilleLoader {
    
    public var villesByCodePostal = [String: Ville]()
    
    public init() {}
    
    public func loadVilles(path: String) throws {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: path) else {
            throw VilleLoaderError.nofile(path: path)
        }
        
        let csvContent = try String(contentsOfFile: path)
        
        var lines = csvContent.components(separatedBy: "\n")
        lines.removeFirst() // eat header line
        for (index, line) in lines.enumerated() where !line.isEmpty {
            if let ville = Ville(fromCsvLine: line) {
                if villesByCodePostal[ville.codePostal] != nil {
                    //print("duplicate code postal for \(ville.codePostal)")
                }
                villesByCodePostal[ville.codePostal] = ville
            } else {
                throw VilleLoaderError.invalidLine(index: index + 1)
            }
        }
    }
    
    public subscript(index: String) -> Ville? {
        return villesByCodePostal[index]
    }
    
}
