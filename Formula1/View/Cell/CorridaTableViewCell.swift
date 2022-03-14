//
//  CorridaTableViewCell.swift
//  Formula1
//
//  Created by Usr_Prime on 04/03/22.
//

import UIKit

class CorridaTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeGpLabel: UILabel!
    @IBOutlet weak var nomePistaLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var bandeiraImage: UIImageView!
    @IBOutlet weak var numeroRoundLabel: UILabel!
    
    func configure(with race: Race) {
        nomeGpLabel.text = race.raceName
        nomePistaLabel.text = race.Circuit.circuitName
        numeroRoundLabel.text = "#\(race.round)"
        dataLabel.text = Utils.convertDate(data: race.date)
        
        //setImage(country: "\(race.Circuit.Location.country)", imageView: bandeiraImage)
    }
    
   
}
