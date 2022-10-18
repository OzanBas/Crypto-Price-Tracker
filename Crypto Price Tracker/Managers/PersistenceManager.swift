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
    
    
    static func saveToFavorites(coin: ListModel) -> CPError? {
        let encoder = JSONEncoder()
        
        do {
            let favorite = try encoder.encode(coin)
            defaults.set(favorite, forKey: Keys.favorites)
            return nil
        } catch {
            return CPError.savingError
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[ListModel], CPError>) -> Void ) {
        let decoder = JSONDecoder()
        
        do {
            guard let retrievedData = defaults.object(forKey: Keys.favorites) as? Data else {
                completion(.success([]))
                return
            }
            let favorites = try decoder.decode([ListModel].self, from: retrievedData)
            completion(.success(favorites))
        } catch {
            completion(.failure(CPError.retrievingFavorites))
        }
    }
}
