//
//  NetworkManager.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit


struct RequestModel {
    let baseURL: String
    let listEndpoint: String?
    let coinEndpoint: String?
    let coinId: String?
    let paginationEndpoint: String?
}



final class NetworkManager {
    
    
    //MARK: - Properties
    static let shared = NetworkManager()
    
    private let baseURL = Endpoints.baseURL
    private let listEndpoint = Endpoints.list
    private let coinEndpoint = Endpoints.coin
    private let paginationEndpoint = Endpoints.pagination
    
    private let decoder = JSONDecoder()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    //MARK: - Request function
    func request<T:Decodable>(endpoint: String, completion: @escaping (_ result: Result<T, CPError>) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        
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
                let result = try self.decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
    
}
