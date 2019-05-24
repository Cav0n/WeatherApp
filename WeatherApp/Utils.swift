//
//  Utils.swift
//  WeatherApp
//
//  Created by Florian Bernard on 24/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import Foundation

public func timeStampToDateString(_ timestamp: Double, dateFormat: String) -> String{
    let date = Date(timeIntervalSince1970: timestamp)
    let dateFormatter = DateFormatter()
    let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
    dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = dateFormat //Specify your format that you want "dd.MM.yyyy HH:mm"
    return dateFormatter.string(from: date)
}
