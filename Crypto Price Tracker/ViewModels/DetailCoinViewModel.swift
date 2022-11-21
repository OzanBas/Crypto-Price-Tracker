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
    private var error: CPError?
    
    
    init(coinId: String) {
        self.coinId = coinId
    }

    
    
    private func generateDetailEndpoint() -> String {
        let endpoint = Endpoints.baseURL + Endpoints.coin + coinId
        return endpoint
    }
    
    
    
    func requestCoinDetails(completion: @escaping(Result<CoinModel, CPError>) -> Void) {
        NetworkManager.shared.request(endpoint: generateDetailEndpoint()) { [weak self] (result: Result<CoinModel, CPError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.coinDetail = response
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


