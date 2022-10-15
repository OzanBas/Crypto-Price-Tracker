//
//  NetworkManager.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


class NetworkManager {
    
    let baseURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
    let listEndpoint = "/coins/markets?vs_currency=usd"
    let decoder = JSONDecoder()
    
    
    func getCoinsList() async throws -> [ListModel] {
        let endpoint = baseURL + listEndpoint
        
        guard let url = URL(string: endpoint) else {
            throw CPError.badEndpoint
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CPError.badResponse
        }
        do {
            return try decoder.decode([ListModel].self, from: data)
        } catch {
            throw CPError.parsingError
        }
    }
    
    
}
