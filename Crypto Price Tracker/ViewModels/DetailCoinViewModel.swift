//
//  DetailCoinViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit


final class DetailCoinViewModel {
    
    
    var coinId: String!
    var coinDetail: CoinModel!
    private var service = NetworkManager()
    private var error: CPError?
    
    
    init(coinId: String) {
        self.coinId = coinId
    }
    
    
    
    
    func getCoinDetails(completion: @escaping (Result<CoinModel, CPError>) -> Void) {
        service.getCoinDetail(coinId: coinId) { result in
            switch result {
            case .success(let coin):
                self.coinDetail = coin
                completion(.success(coin))
            case .failure(let cpError):
                completion(.failure(cpError))
            }
        }
    }
}


