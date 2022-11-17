//
//  NetworkManager.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit


final class NetworkManager {

//MARK: - Properties
    private let baseURL = Endpoints.baseURL
    private let listEndpoint = Endpoints.list
    private let coinEndpoint = Endpoints.coin
    private let paginationEndpoint = Endpoints.pagination
    
    private let decoder = JSONDecoder()
    private let cache = NSCache<NSString, UIImage>()
    
    //MARK: - Fetch List
    func getCoinsList(page: Int) async throws -> [ListModel] {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let pageString = String(page)
        let endpoint = baseURL + listEndpoint + paginationEndpoint + pageString
        
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
    
    //MARK: - Fetch Coin Details
    func getCoinDetail(coinId: String, completion: @escaping (Result<CoinModel, CPError>) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        
        let endpoint = baseURL + coinEndpoint + coinId
        print(endpoint)
        let url = URL(string: endpoint)
        
        guard let url = url else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.badEndpoint))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                let coin = try self.decoder.decode(CoinModel.self, from: data)
                completion(.success(coin))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
    
    //MARK: - Fetch Coin Images
    func getCoinImage(for imageUrl: String, completion: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: imageUrl)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: imageUrl) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard self != nil else { return }
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        dataTask.resume()
    }
}
