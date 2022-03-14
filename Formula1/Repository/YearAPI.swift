//
//  YearAPI.swift
//  Formula1
//
//  Created by Usr_Prime on 07/03/22.
//

import Foundation

class YearAPI {
    static let shared = YearAPI()
    func getYear(completion: @escaping (Result<SeasonTable, Error>) -> Void) {
        guard let url = URL(string: "https://ergast.com/api/f1/seasons.json?limit=100") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(YearAPIResponse.self, from: data)
                completion(.success(result.MRData.SeasonTable))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
