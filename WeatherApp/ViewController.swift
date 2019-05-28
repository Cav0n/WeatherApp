//
//  ViewController.swift
//  WeatherApp
//
//  Created by Richard Bergoin on 21/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import UIKit
import WeatherLib

class ViewController: UIViewController {

    let villeLoader = VilleLoader()
    var villes : [Ville] = []
    var weatherDetailViewController: WeatherDetailViewController? = nil

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather App" //Titre de la page
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage() // Pour supprimer la bordure en bas du titre
        
        let path = Bundle.main.path(forResource: "villes", ofType: "csv")!
        try! villeLoader.loadVillesSimple(path: path)
        
        villeLoader.villes.sorted { $0 < $1 }.forEach({ (ville) in
            if(ville.nom.trimmingCharacters(in: .whitespacesAndNewlines).count > 0){
                villes.append(ville)
            }
        })
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            weatherDetailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? WeatherDetailViewController
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let ville = villes[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! WeatherDetailViewController
                controller.ville = ville
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VilleTableViewCell", for: indexPath)
        
        (cell as! VilleTableViewCell).VilleLabel.text = villes[indexPath.row].nom
        (cell as! VilleTableViewCell).CodePostalLabel.text = villes[indexPath.row].codePostal
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
