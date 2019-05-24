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

extension VilleDetailViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.hourly.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailTableViewCell")
        let data = weather.hourly.data[indexPath.row]
        
        (cell as! WeatherDetailTableViewCell).temperatureLabel.text = "\(String(format: "%.2f °C", (data.temperature - 32) / 1.8))"
        (cell as! WeatherDetailTableViewCell).timeLabel.text = "\(timeStampToDateString(data.time, dateFormat: "d MMM HH'h'mm"))"
        (cell as! WeatherDetailTableViewCell).descriptionLabel.text = data.summary
        return cell!
    }
    
    
}
