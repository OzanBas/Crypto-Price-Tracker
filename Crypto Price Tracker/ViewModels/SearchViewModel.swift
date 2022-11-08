//
//  SearchViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 8.11.2022.
//

import Foundation

class SearchViewModel {
    
    let service = NetworkManager()
    var coinDetails: CoinModel!
    var coinId: String?
    
    func getCoinDetails(completion: @escaping (Result<CoinModel, CPError>) -> Void) {
        guard let coinId = coinId else { return }
        service.getCoinDetail(coinId: coinId) { result in
            switch result {
            case .success(let coin):
                completion(.success(coin))
                self.coinDetails = coin
            case .failure(let cpError):
                completion(.failure(cpError))
            }
        }
    }
}
