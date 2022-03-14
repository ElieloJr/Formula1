//
//  RaceAPIResponse.swift
//  Formula1
//
//  Created by Usr_Prime on 04/03/22.
//

import Foundation
struct RaceAPIResponse: Codable  {
    let MRData: MRData
}
struct MRData: Codable {
    let RaceTable: RaceTable
}

struct RaceTable: Codable {
    let season: String
    let Races: [Race]
}

struct Race: Codable {
    let round: String
    let raceName: String
    let Circuit: Circuit
    let date: String
    let Results: [RaceResult]?
}

struct RaceResult: Codable {
    let position: String
    let Driver: Driver
    let Constructor: Constructor
    let Time: Time?
}
struct Time: Codable {
    let time: String
}
struct Driver: Codable {
    let givenName: String
    let familyName: String
    let nationality: String
}
struct Constructor: Codable {
    let name: String
}
struct Circuit: Codable {
    let circuitName: String
    let Location: Location
}
struct Location: Codable {
    let country: String
    let lat: String
    let long: String
}
