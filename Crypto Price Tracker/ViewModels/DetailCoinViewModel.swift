//
//  DetailCoinViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import Foundation


class DetailCoinViewModel {
    
    var coin: ListModel!
    var service = NetworkManager()

    
    init(coin: ListModel) {
        self.coin = coin
    }
    
    
    func setVCElements(for detailVC: DetailCoinViewController) {
        detailVC.coinTitleLabel.text = coin.name
        detailVC.coinPriceLabel.text = coin.currentPrice.formatToDisplayablePriceText()
        detailVC.coinPriceChangeLabel.text = coin.priceChangePercentage24H.formatToDisplayablePriceChangeText()
        detailVC.priceChangeImageView.configurePriceChangeImage(for: coin)
        service.getCoinImage(for: coin.image) { image in
            DispatchQueue.main.async {
                detailVC.coinLogoImageView.image = image
            }
        }
    }
    
}
