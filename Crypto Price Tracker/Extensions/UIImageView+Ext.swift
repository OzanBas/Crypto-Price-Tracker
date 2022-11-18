//
//  UIImageView+Ext.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 21.10.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func configurePriceChangeImage(for coin: ListModel) {
        guard let coinChange = coin.priceChangePercentage24H else { return }
        guard coinChange > 0 else {
            image = Images.priceChangeDown
            tintColor = .systemRed
            return
        }
        image = Images.priceChangeUp
        tintColor = .systemGreen
    }
    
    func setImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        kf.setImage(with: url)
    }
}
