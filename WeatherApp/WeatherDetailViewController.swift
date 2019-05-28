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
    
    var weather : Weather? = nil
    var ville : Ville? = nil
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage() // Pour supprimer la bordure en bas du titre
        
        if ville != nil{
            navigationItem.title = ville!.nom
            
            weather =  WeatherService.weatherForVille(ville!).0!
            temperatureLabel.text = String(format: "%.2f °C", ((weather?.currently.temperature)! - 32) / 1.8)
            summaryLabel.text = "\(weather!.currently.summary))"
        } else {
            temperatureLabel.text = ""
            summaryLabel.text = "Aucune ville selectionnée."
        }
    }
}
