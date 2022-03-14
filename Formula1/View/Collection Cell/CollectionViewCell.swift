//
//  CollectionViewCell.swift
//  Formula1
//
//  Created by Usr_Prime on 10/03/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filtroView: UIView!
    @IBOutlet weak var nomePistaLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with race: Race) {
        setImage(country: race.Circuit.Location.country)
        nomePistaLabel.text = race.Circuit.circuitName
    }
    func setImage(country: String) {
        var pais = country
        switch country {
            case "United States":
                pais = "usa"
            case "Saudi Arabia":
                pais = "SA"
            case "UK":
                pais = "UA"
            case "UAE":
                pais = "AE"
        case "Russia":
                pais = "RUS"
        case "South Africa":
            pais = "ZA"
            default: break
        }
        guard let imageURL = URL(string: "https://countryflagsapi.com/png/\(pais)") else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.flagImageView.image = image
            }
        }
    }
}
