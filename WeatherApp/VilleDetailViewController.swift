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
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ville?.nom
        self.navigationItem.prompt = ville?.codePostal
        
        let weather = WeatherService.weatherForVille(ville).0!
        let weatherTemperatureInCelsius = String(format: "%.2f °C", (weather.currently.temperature - 32) / 1.8)
        temperatureLabel.text = weatherTemperatureInCelsius
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
