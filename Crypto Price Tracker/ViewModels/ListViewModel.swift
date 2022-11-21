//
//  ListViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


final class ListViewModel {
    
    var coins: [ListModel] = []
    var filteredCoins: [ListModel] = []
    var page: Int = 1
    var moreCoinsAvailable = true
    var isLoadingMoreCoins = false
    
    //        let endpoint = baseURL + listEndpoint + paginationEndpoint + pageString

    func generateEndpoint(for page: Int) -> String {
        let endpoint = Endpoints.baseURL + Endpoints.list + Endpoints.pagination + String(page)
        return endpoint
    }
    
    
    
    func getCoinsList(completion: @escaping(Result<[ListModel], CPError>) -> Void) {
        
        isLoadingMoreCoins = true
        NetworkManager.shared.request(endpoint: generateEndpoint(for: page)) { [weak self] (result: Result<[ListModel], CPError>) in
            guard let self = self else { return }
            switch result {
            case .success(let coins):
                if coins.count < 100 { self.moreCoinsAvailable = false }
                self.coins.append(contentsOf: coins)
                completion(.success(coins))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        isLoadingMoreCoins = false
    }
}
