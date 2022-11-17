//
//  SearchViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 8.11.2022.
//

import Foundation

final class SearchViewModel {
    
    private let service = NetworkManager()
    var coinDetails: CoinModel!
    var coinId: String?
    
    func getCoinDetails(completion: @escaping (Result<CoinModel, CPError>) -> Void) {
        guard let coinId = coinId else { return }
        service.getCoinDetail(coinId: coinId) { result in
            switch result {
            case .success(let coin):
                self.coinDetails = coin
                completion(.success(coin))
            case .failure(let cpError):
                completion(.failure(cpError))
            }
        }
    }
}
