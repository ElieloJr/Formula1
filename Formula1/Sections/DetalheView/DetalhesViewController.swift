//
//  DetalhesViewController.swift
//  Formula1
//
//  Created by Usr_Prime on 07/03/22.
//

import UIKit
import MapKit

class DetalhesViewController: UIViewController {
    
    var viewModel = DetalheViewModel()

    @IBOutlet weak var detalheTableView: UITableView!
    @IBOutlet weak var mapaView: MKMapView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var imageCountryRace: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameGPLabel: UILabel!
    @IBOutlet weak var namePistaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        detalheTableView.delegate = self
        detalheTableView.dataSource = self
        detalheTableView.register(UINib(nibName: "DetalheCelulaTableViewCell", bundle: nil), forCellReuseIdentifier: "DetalheCelulaTableViewCell")
        
        roundLabel.text = "#\(viewModel.round)"
        countryLabel.text = viewModel.pais
        nameGPLabel.text = viewModel.nomeGP
        namePistaLabel.text = viewModel.nomePista
        dateLabel.text = Utils.convertDate(data: viewModel.data)
        viewModel.setImage(country: viewModel.pais)
        
        viewModel.getDataRace()
        viewModel.getDataCountry()
    }
}
extension DetalhesViewController: UITableViewDelegate {}
extension DetalhesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.detalheList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalheCelulaTableViewCell") as! DetalheCelulaTableViewCell
        cell.configuraCelula(driver: viewModel.detalheList[indexPath.row], country: viewModel.countryList)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension DetalhesViewController: DetalheViewDelegate {
    func changeScreen() {
        //
    }
    func reloadData() {
        DispatchQueue.main.async {
            self.detalheTableView.reloadData()
        }
    }
    func showError(with message: String) {
        print(message)
    }
    
    func setImage(_ countryImage: UIImage?) {
        DispatchQueue.main.async {
            self.imageCountryRace.image = countryImage
        }
    }
    func positionMap(to location: Location) {
        DispatchQueue.main.async {
            let center = CLLocationCoordinate2D(latitude: Double(location.lat)!, longitude: Double(location.long)!)
            self.mapaView.setRegion(MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: Double(1), longitudeDelta: Double(1))), animated: true)
        }
    }
}
