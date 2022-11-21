//
//  SearchViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 8.11.2022.
//

import Foundation

final class SearchViewModel {
    
    var coinDetails: CoinModel!
    var coinId: String?
    
    private func generateDetailEndpoint() -> String {
        let endpoint = Endpoints.baseURL + Endpoints.coin + (coinId ?? "")
        return endpoint
    }
    
    func getCoinDetails(completion: @escaping (Result<CoinModel, CPError>) -> Void) {

        NetworkManager.shared.request(endpoint: generateDetailEndpoint()) { [weak self] (result: Result<CoinModel, CPError>)  in
            guard let self = self else { return }
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
