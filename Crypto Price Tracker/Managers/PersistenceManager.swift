//
//  PersistenceManager.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import Foundation


enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(favorite: CoinModel, completion: @escaping(CPError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                print(favorites.count)
                    if favorites.contains(where: { $0.name == favorite.name })  {
                        favorites.removeAll { $0.name == favorite.name }
                        let error = saveToFavorites(coins: favorites)
                        guard error == nil else {
                            completion(.savingError)
                            return
                        }
                        completion(.removingAlert)
                        return
                    } else {
                        favorites.append(favorite)
                        let error = saveToFavorites(coins: favorites)
                        guard error == nil else {
                            completion(.savingError)
                            return
                        }
                        completion(.addingAlert)
                    }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    static func saveToFavorites(coins: [CoinModel]) -> CPError? {
        
        do {
            let encoder = JSONEncoder()
            let favorite = try encoder.encode(coins)
            defaults.set(favorite, forKey: Keys.favorites)
            return nil
        } catch {
            return .savingError
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[CoinModel], CPError>) -> Void) {
        guard let retrievedData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([CoinModel].self, from: retrievedData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.retrievingFavorites))
        }
    }
    
    
}

