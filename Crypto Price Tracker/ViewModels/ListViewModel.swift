//
//  ListViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


final class ListViewModel {
    
    let service = NetworkManager()
    var coins: [ListModel] = []
    var filteredCoins: [ListModel] = []
    var page: Int = 1
    var moreCoinsAvailable = true
    var isLoadingMoreCoins = false
    
    
    func getCoinsList(completion: @escaping(Result<[ListModel], CPError>) -> Void) {
        
        Task{
            isLoadingMoreCoins = true
            do {
                let fetchedCoins = try await service.getCoinsList(page: page)
                if fetchedCoins.count < 100  { moreCoinsAvailable = false}
                self.coins.append(contentsOf: fetchedCoins)
                completion(.success(fetchedCoins))
            } catch {
                if let cpError = error as? CPError {
                    completion(.failure(cpError))
                }
            }
            isLoadingMoreCoins = false
        }
    }
}
