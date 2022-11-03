//
//  DetailCoinViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit


class DetailCoinViewModel {
    
    
    var coin: ListModel!
    var coinDetail: CoinModel!
    var coinName: String!
    var service = NetworkManager()
    var error: CPError?
    
    
    init(coin: ListModel) {
        self.coin = coin
        self.coinName = coin.id
    }
    
    
    
    
    func getCoinDetails(completion: @escaping (Result<CoinModel, CPError>) -> Void) {
        service.getCoinDetail(coinName: coinName) { result in
            switch result {
            case .success(let coin):
                completion(.success(coin))
                self.coinDetail = coin
                self.coinName = coin.name
            case .failure(let cpError):
                completion(.failure(cpError))
            }
        }
    }
}

