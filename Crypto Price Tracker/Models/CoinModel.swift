//
//  CoinModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import Foundation


struct CoinModel: Codable {
    let id: String
    let symbol: String
    let name: String
    let blockTimeInMinutes: Int
    let hashingAlgorithm: String
    let categories: [String]
    let welcomeDescription: Tion
    let image: Image
    let countryOrigin: String
    let genesisDate: String
    let sentimentVotesUpPercentage: Double
    let sentimentVotesDownPercentage: Double
    let marketCapRank: Int
    let lastUpdated: String
}



// MARK: - Image
struct Image: Codable {
    let thumb: String
    let small: String
    let large: String
}


// MARK: - Tion
struct Tion: Codable {
    let en: String
}
