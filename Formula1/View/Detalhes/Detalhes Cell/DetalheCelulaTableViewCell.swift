//
//  DetalheCelulaTableViewCell.swift
//  Formula1
//
//  Created by Usr_Prime on 08/03/22.
//

import UIKit

class DetalheCelulaTableViewCell: UITableViewCell {

    @IBOutlet weak var posicaoLabel: UILabel!
    @IBOutlet weak var nomePilotoLabel: UILabel!
    @IBOutlet weak var equipeLabel: UILabel!
    @IBOutlet weak var melhorTempoLabel: UILabel!
    @IBOutlet weak var velocidadeMediaLabel: UILabel!
    @IBOutlet weak var bandeiraImageView: UIImageView!
    var origem = ""
    
    func configuraCelula(driver: RaceResult, country: [CountryAPIResponse]) {
        posicaoLabel.text = driver.position
        nomePilotoLabel.text = "\(driver.Driver.givenName) \(driver.Driver.familyName)"
        equipeLabel.text = driver.Constructor.name
        melhorTempoLabel.text = "\(driver.Time?.time ?? "----")"
        velocidadeMediaLabel.text = "\(driver.FastestLap?.AverageSpeed.speed ?? "----") kph"
        for nat in country {
            if nat.demonym == driver.Driver.nationality {
                if nat.demonym == "British" { origem = "GB-ENG" }
                else { origem = nat.common_name }
            }
        }
        setImage(country: self.origem)
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
                self.bandeiraImageView.image = image
            }
        }
    }
}
