//
//  YearAPIResponse.swift
//  Formula1
//
//  Created by Usr_Prime on 07/03/22.
//

import Foundation

struct YearAPIResponse: Codable {
    let MRData: MRDataYear
}
struct MRDataYear: Codable {
    let	SeasonTable: SeasonTable
}
struct SeasonTable: Codable {
    let Seasons: [Season]
}
struct Season: Codable{
    let season: String
}
