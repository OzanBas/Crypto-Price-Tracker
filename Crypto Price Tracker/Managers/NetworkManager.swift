//
//  NetworkManager.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit


class NetworkManager {
    
    private let baseURL = "https://api.coingecko.com/api/v3"
    private let listEndpoint = "/coins/markets?vs_currency=usd"
    private let coinEndpoint = "?tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    private let decoder = JSONDecoder()
    private let cache = NSCache<NSString, UIImage>()
    
  
    func getCoinsList() async throws -> [ListModel] {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let endpoint = baseURL + listEndpoint
        
        guard let url = URL(string: endpoint) else {
            throw CPError.badEndpoint
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw CPError.badResponse
            }
            do {
                return try decoder.decode([ListModel].self, from: data)
            } catch {
                throw CPError.parsingError
            }
        } catch {
            throw CPError.NoInternetConnection
        }
    }
    
    
    func getCoinImage(for imageUrl: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard self != nil else { return }
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        dataTask.resume()
    }
    
    
}
