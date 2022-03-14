//
//  ListViewModel.swift
//  Formula1
//
//  Created by Luiz Carlos Queiroz Cunha Filho on 14/03/22.
//

import Foundation



class ListViewModel {
    var seasonNumber = ""
    var raceList: [Race] = []
    var selectedRace: Race?
    var api: RaceAPIProtocol = RaceAPI.shared
    var delegate: ListViewDelegate?
    
    
    func clickedCellAt(raceNumber: Int) {
        self.selectedRace = self.raceList[raceNumber]
        self.delegate?.changeScreen()
    }
    func getData() {
        self.api.getGP(year: seasonNumber) { result in
            switch result {
            case .success(let raceTable):
                self.seasonNumber = raceTable.season
                self.raceList = raceTable.Races
                self.delegate?.reloadData()
            case .failure(let error):
                self.delegate?.showError()
                print(error)
            }
        }
    }
}
