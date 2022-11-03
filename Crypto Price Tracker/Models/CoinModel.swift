//
//  CoinModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import Foundation



// MARK: - Welcome
struct CoinModel: Codable {
    var symbol: String?
    var name: String?
    var localization: Tion?
    var description: Tion?
    var links: Links
    var image: Image
    var marketCapRank: Int?
    var marketData: MarketData
    var lastUpdated: String?
}



// MARK: - Links
struct Links: Codable {
    var homepage: [String]?
}

// MARK: - Tion
struct Tion: Codable {
    var en: String?
}

// MARK: - MarketData
struct MarketData: Codable {
    var currentPrice: [String: Double]?
    var ath: [String: Double]?
    var athChangePercentage: [String: Double]?
    var athDate: [String: String]?
    var atlChangePercentage: [String: Double]?
    var marketCap: [String: Double]?
    var marketCapRank: Int?
    var fullyDilutedValuation: [String: Double]?
    var totalVolume: [String: Double]?
    var high24H: [String: Double]?
    var low24H: [String: Double]?
    var priceChange24H: Double?
    var priceChangePercentage24H: Double?
    var marketCapChange24H: Double?
    var marketCapChangePercentage24H: Double?
    var totalSupply: Double?
    var circulatingSupply: Double?
    var lastUpdated: String?
}


struct Image: Codable {
    var thumb: String
    var small: String
    var large: String
}

