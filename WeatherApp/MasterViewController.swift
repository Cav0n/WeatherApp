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
    
    var villes : [Ville] = []
    
    let villeLoader = VilleLoader()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try villeLoader.loadVilles(path: Bundle.main.path(forResource: "villes", ofType: "csv")!)
            villeLoader.villesByCodePostal.sorted { $0.value.nom < $1.value.nom }.forEach { (arg0) in
                let ville = arg0.value
                if(ville.nom.trimmingCharacters(in: .whitespacesAndNewlines).count > 0){
                    villes.append(ville)
                }
            }
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let tableViewCellSelected = (tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! VilleTableViewCell)
        loadingFeedbackOnSelectedVilleCell(activate: true, cell: tableViewCellSelected)
        let ville = villeLoader[tableViewCellSelected.codePostalLabel.text!]
        (segue.destination as! VilleDetailViewController).ville = ville.self
        (segue.destination as! VilleDetailViewController).weather = WeatherService.weatherForVille(ville!).0!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToDetailViewController", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
        loadingFeedbackOnSelectedVilleCell(activate: false, cell: tableView.cellForRow(at: indexPath) as! VilleTableViewCell)
    }
    
    func loadingFeedbackOnSelectedVilleCell(activate: Bool, cell selectedCell: VilleTableViewCell){
        if(activate){
            selectedCell.codePostalLabel.alpha = 0
            selectedCell.activityIndicator.alpha = 1
            selectedCell.activityIndicator.startAnimating()
        } else {
            selectedCell.codePostalLabel.alpha = 1
            selectedCell.activityIndicator.alpha = 0
            selectedCell.activityIndicator.stopAnimating()
        }
    }
}

extension MasterViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villeLoader.villesByCodePostal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VilleTableViewCell", for: indexPath)
        
        let ville = villes[indexPath.row]
        
        (cell as! VilleTableViewCell).villeLabel.text =  ville.nom.capitalizingFirstLetter()
        (cell as! VilleTableViewCell).codePostalLabel.text = ville.codePostal
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
