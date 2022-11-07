//
//  DetailCoinViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit


class DetailCoinViewModel {
    
    
    var coinId: String!
    var coinDetail: CoinModel!
    var service = NetworkManager()
    var error: CPError?
    
    
    init(coinId: String) {
        self.coinId = coinId
    }
    
    
    
    
    func getCoinDetails(completion: @escaping (Result<CoinModel, CPError>) -> Void) {
        service.getCoinDetail(coinId: coinId) { result in
            switch result {
            case .success(let coin):
                completion(.success(coin))
                self.coinDetail = coin
            case .failure(let cpError):
                completion(.failure(cpError))
            }
        }
    }
}


