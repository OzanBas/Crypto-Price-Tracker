//
//  FavoritesViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 7.11.2022.
//

import Foundation

final class FavoritesViewModel {
    
    
    var favoriteCoins: [CoinModel] = []

    
    func loadFavorites(completion: @escaping(Result<[CoinModel], CPError>) -> Void) {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coins):
                self.favoriteCoins = coins
                completion(.success(coins))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
