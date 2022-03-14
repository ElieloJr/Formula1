//
//  RaceAPI.swift
//  Formula1
//
//  Created by Usr_Prime on 04/03/22.
//

import Foundation

protocol RaceAPIProtocol: AnyObject {
    func getGP(year: String, completion: @escaping (Result<RaceTable, Error>) -> Void)
}

class RaceAPIMock: RaceAPIProtocol {
    
    static let shared = RaceAPIMock()
    
    func getGP(year: String, completion: @escaping (Result<RaceTable, Error>) -> Void) {
        
    }
}

class RaceAPI: RaceAPIProtocol {
    static let shared = RaceAPI()
    
    func getGP(year: String, completion: @escaping (Result<RaceTable, Error>) -> Void) {
        guard let url = URL(string: "https://ergast.com/api/f1/\(year).json") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(RaceAPIResponse.self, from: data)
                completion(.success(result.MRData.RaceTable))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
