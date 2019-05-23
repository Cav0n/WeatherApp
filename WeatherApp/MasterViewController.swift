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
    
    var villes : [String : Ville] = [:]
    var zips : [String] = []
    var noms : [String] = []
    
    let villeLoader = VilleLoader()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try villeLoader.loadVilles(path: Bundle.main.path(forResource: "villes", ofType: "csv")!)
            villeLoader.villesByCodePostal.keys.sorted().forEach { (key) in
                let value = villeLoader.villesByCodePostal[key]!.self
                zips.append(key)
                noms.append(value.nom)
                villes[key] = value
            }
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let tableViewCellSelected = (tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! VilleTableViewCell)
        let ville = villes[tableViewCellSelected.codePostalLabel.text!]
        
        (segue.destination as! VilleDetailViewController).ville = ville.self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToDetailViewController", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MasterViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VilleTableViewCell", for: indexPath)
        
        let villeCodePostal = zips[indexPath.row]
        let villeNom =  villes[villeCodePostal]?.nom.capitalizingFirstLetter()
        
        (cell as! VilleTableViewCell).villeLabel.text = villeNom
        (cell as! VilleTableViewCell).codePostalLabel.text = villeCodePostal
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
