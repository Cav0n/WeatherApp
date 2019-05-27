//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Florian Bernard on 27/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import UIKit
import WeatherLib

class WeatherDetailViewController: UIViewController {
    
    var weather : Weather!
    var ville : Ville!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ville.nom
        
        weather = WeatherService.weatherForVille(ville!).0!
        temperatureLabel.text = String(format: "%.2f °C", (weather.currently.temperature - 32) / 1.8)
        summaryLabel.text = "\(weather.currently.summary)"
    }
}
