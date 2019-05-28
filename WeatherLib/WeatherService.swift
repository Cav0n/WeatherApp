//
//  WeatherService.swift
//  WeatherLib
//
//  Created by Richard Bergoin on 10/02/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import Foundation

public class WeatherService: NSObject {
    
    public static func startWeatherForVille(_ ville: Ville, completionHandler: @escaping (Weather?, Error?) -> Void) {
        guard let url = URL(string: "https://api.darksky.net/forecast/8b24b1d4d6d535727cd03c4cc0d04350/\(ville.latitude),\(ville.longitude)?lang=fr") else {
            fatalError("unable to generate URL for weather of \(ville)")
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            } else if let weather = Weather(data: data) {
                completionHandler(weather, nil)
            } else {
                fatalError("neither error nor weather creation from data")
            }
        }
        dataTask.resume()
    }
    
    public static func weatherForVille(_ ville: Ville) -> (Weather?, Error?) {
        var weather: Weather? = nil
        var error: Error? = nil
        var ended = false
        startWeatherForVille(ville) { (w, e) in
            weather = w
            error = e
            ended = true
        }
        repeat {
            let date = Date(timeIntervalSinceNow: 0.1)
            RunLoop.current.run(until: date)
        } while ended == false
        return (weather, error)
    }
    
}
