//
//  CountryAPI.swift
//  Formula1
//
//  Created by Usr_Prime on 09/03/22.
//

import Foundation

class CountryAPI {
    static let shared = CountryAPI()
    func getCountry(completion: @escaping (Result<[CountryAPIResponse], Error>) -> Void) {
        guard let url = URL(string: "https://api.manatal.com/open/v3/nationalities/") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode([CountryAPIResponse].self, from: data)
                //print(result.common_name)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
