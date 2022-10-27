//
//  ListViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


class ListViewModel {
    
    let service = NetworkManager()
    var coins: [ListModel] = []
    var filteredCoins: [ListModel] = []
    
    
    func getCoinsList(completion: @escaping(Result<[ListModel], CPError>) -> Void) {
        
        Task{
            do {
                let fetchedCoins = try await service.getCoinsList()
                completion(.success(fetchedCoins))
                self.coins = fetchedCoins
            } catch {
                if let cpError = error as? CPError {
                    completion(.failure(cpError))
                }
            }
        }
    }
}
