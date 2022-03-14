//
//  ViewController.swift
//  Formula1
//
//  Created by Usr_Prime on 04/03/22.
//

import UIKit

protocol ListViewDelegate: AnyObject {
    func changeScreen()
    func reloadData()
    func showError()
}

class ListaViewController: UIViewController {

    let viewModel = ListViewModel()

    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        guard let dados = segue.destination as? DetalhesViewController, let race = self.viewModel.selectedRace else { return }
        dados.round = race.round
        dados.nomeGP = race.raceName
        dados.nomePista = race.Circuit.circuitName
        dados.pais = race.Circuit.Location.country
        dados.data = race.date
        dados.year = self.viewModel.seasonNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getData()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        homeCollectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    }
}

extension ListaViewController: ListViewDelegate {
    func changeScreen() {
        self.performSegue(withIdentifier: "DetalheRace", sender: nil)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
    func showError() {
        //
    }
}

extension ListaViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.clickedCellAt(raceNumber: indexPath.row)
    }
}
extension ListaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.raceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { fatalError() }
        cell.configure(with: self.viewModel.raceList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            headerView.setYear(self.viewModel.seasonNumber)
            return headerView
        }
        return UICollectionReusableView()
    }
}
extension ListaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionsView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}
