//
//  DetalhesViewController.swift
//  Formula1
//
//  Created by Usr_Prime on 07/03/22.
//

import UIKit
import MapKit

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var mapaView: MKMapView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var imageCountryRace: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameGPLabel: UILabel!
    @IBOutlet weak var namePistaLabel: UILabel!
    
    var round = ""
    var year = ""
    var pais = ""
    var nomeGP = ""
    var nomePista = ""
    var data = ""
    
    var detalheList: [RaceResult] = []
    var countryList: [CountryAPIResponse] = []
    
    @IBOutlet weak var detalheTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detalheTableView.delegate = self
        detalheTableView.dataSource = self
        detalheTableView.register(UINib(nibName: "DetalheCelulaTableViewCell", bundle: nil), forCellReuseIdentifier: "DetalheCelulaTableViewCell")
        
        roundLabel.text = "#\(round)"
        countryLabel.text = pais
        nameGPLabel.text = nomeGP
        namePistaLabel.text = nomePista
        dateLabel.text = Utils.convertDate(data: data)
        setImage(country: pais)
        
        DetalheRaceAPI.shared.getRace(year: year, round: round) { result in
            switch result {
            case .success(let resultTable):
                self.detalheList = resultTable.Races[0].Results!
                DispatchQueue.main.async {
                    self.detalheTableView.reloadData()
                    let circuitData = resultTable.Races[0].Circuit.Location
                    let center = CLLocationCoordinate2D(latitude: Double(circuitData.lat)!, longitude: Double(circuitData.long)!)
                    self.mapaView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: Double(1), longitudeDelta: Double(1))), animated: true)
                }
            case .failure(let error):
                print("Deu ruim", error)
            }
        }
        CountryAPI.shared.getCountry { result in
            switch result {
            case .success(let countryTable):
                self.countryList = countryTable
                DispatchQueue.main.async {
                    self.detalheTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
                self.imageCountryRace.image = image
            }
        }
    }
}
extension DetalhesViewController: UITableViewDelegate {
    
}
extension DetalhesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detalheList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalheCelulaTableViewCell") as! DetalheCelulaTableViewCell
        cell.configuraCelula(driver: detalheList[indexPath.row], country: countryList)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
