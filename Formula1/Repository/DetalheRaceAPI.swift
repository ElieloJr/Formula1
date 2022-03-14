//
//  DetalheRaceAPI.swift
//  Formula1
//
//  Created by Usr_Prime on 08/03/22.
//

import Foundation

class DetalheRaceAPI {
    static let shared = DetalheRaceAPI()
    func getRace(year: String, round: String, completion: @escaping (Result<RaceTable, Error>) -> Void) {
        guard let url = URL(string: "https://ergast.com/api/f1/\(year)/\(round)/results.json") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, error in
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
