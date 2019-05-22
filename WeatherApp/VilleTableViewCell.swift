//
//  VilleTableViewCell.swift
//  WeatherApp
//
//  Created by Florian Bernard on 22/05/2019.
//  Copyright © 2019 Openium. All rights reserved.
//

import UIKit

class VilleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
