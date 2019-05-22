//
//  ViewController.swift
//  WeatherApp
//
//  Created by Richard Bergoin on 21/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import UIKit
import WeatherLib

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var villes : [String:Ville] = [:]
    var villesNames : [String] = []
    let villeLoader = VilleLoader()
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VilleTableViewCell", for: indexPath)
        let ville = villes.popFirst()?.value
        (cell as! VilleTableViewCell).nameLabel.text = ville?.nom
        (cell as! VilleTableViewCell).zipCodeLabel.text = ville?.codePostal
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try villeLoader.loadVilles(path: Bundle.main.path(forResource: "villes", ofType: "csv")!)
        }catch{
            print(error)
        }
        villes = villeLoader.villesByCodePostal

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let villeDetailVC = segue.destination as? VilleDetailVC else { return }
        villeDetailVC.villeNom.text = "yo"
    }

}

