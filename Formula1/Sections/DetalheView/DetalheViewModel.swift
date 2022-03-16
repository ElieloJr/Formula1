//
//  DetalheViewModel.swift
//  Formula1
//
//  Created by Usr_Prime on 16/03/22.
//

import UIKit

protocol DetalheViewDelegate: UtilProtocolDelegate {
    func positionMap(to location: Location)
    func setImage(_ countryImage: UIImage?)
}

class DetalheViewModel {
    var round = ""
    var year = ""
    var pais = ""
    var nomeGP = ""
    var nomePista = ""
    var data = ""
    
    var detalheList: [RaceResult] = []
    var countryList: [CountryAPIResponse] = []
    var delegate: DetalheViewDelegate?
    
    func getDataRace() {
        DetalheRaceAPI.shared.getRace(year: year, round: round) { result in
            switch result {
            case .success(let resultTable):
                self.detalheList = resultTable.Races[0].Results!
                self.delegate?.reloadData()
                self.delegate?.positionMap(to: resultTable.Races[0].Circuit.Location)
                
            case .failure(let error):
                self.delegate?.showError(with: "Deu ruim -> \(error)")
            }
        }
    }
    func getDataCountry() {
        CountryAPI.shared.getCountry { result in
            switch result {
            case .success(let countryTable):
                self.countryList = countryTable
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.showError(with: "\(error)")
            }
        }
    }
    
    func setImage(country: String) {
        let pais = Utils.filterCountry(country)
        guard let imageURL = URL(string: "https://countryflagsapi.com/png/\(pais)") else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            self.delegate?.setImage(image)
        }
    }
}
