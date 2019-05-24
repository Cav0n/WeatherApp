//
//  MasterViewController.swift
//  WeatherApp
//
//  Created by Florian Bernard on 23/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import UIKit
import WeatherLib

class MasterViewController: UIViewController {
    
    var zips : [String] = []
    var noms : [String] = []
    
    let villeLoader = VilleLoader()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try villeLoader.loadVilles(path: Bundle.main.path(forResource: "villes", ofType: "csv")!)
            villeLoader.villesByCodePostal.sorted { $0.value.nom < $1.value.nom }.forEach { (arg0) in
                let codepostal = arg0.key
                let nom = arg0.value.nom.trimmingCharacters(in: .whitespacesAndNewlines)
                if(nom.count > 0){
                    zips.append(codepostal)
                    noms.append(nom)
                }
            }
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableViewCellSelected = (tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! VilleTableViewCell)
        tableViewCellSelected.codePostalLabel.alpha = 0
        tableViewCellSelected.activityIndicator.alpha = 1
        tableViewCellSelected.activityIndicator.startAnimating()
        
        let ville = villeLoader[tableViewCellSelected.codePostalLabel.text!]
        (segue.destination as! VilleDetailViewController).ville = ville.self
        (segue.destination as! VilleDetailViewController).weather = WeatherService.weatherForVille(ville!).0!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToDetailViewController", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
        (tableView.cellForRow(at: indexPath) as! VilleTableViewCell).codePostalLabel.alpha = 1
        (tableView.cellForRow(at: indexPath) as! VilleTableViewCell).activityIndicator.alpha = 0
        (tableView.cellForRow(at: indexPath) as! VilleTableViewCell).activityIndicator.stopAnimating()
    }
}

extension MasterViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villeLoader.villesByCodePostal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VilleTableViewCell", for: indexPath)
        
        let codePostal = zips[indexPath.row]
        let nom = noms[indexPath.row]
        
        (cell as! VilleTableViewCell).villeLabel.text =  nom.capitalizingFirstLetter()
        (cell as! VilleTableViewCell).codePostalLabel.text = codePostal
        return cell
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
