//
//  VilleDetailViewController.swift
//  WeatherApp
//
//  Created by Florian Bernard on 23/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import UIKit
import WeatherLib

class VilleDetailViewController: UIViewController {

    var ville : Ville!
    var weather : Weather!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ville?.nom
        
        let weatherTemperatureInCelsius = String(format: "%.2f °C", (weather.currently.temperature - 32) / 1.8)
        temperatureLabel.text = weatherTemperatureInCelsius
        descriptionLabel.text = weather.currently.summary
    }

}
