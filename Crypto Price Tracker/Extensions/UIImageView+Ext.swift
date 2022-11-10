//
//  UIImageView+Ext.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 21.10.2022.
//

import UIKit

extension UIImageView {
    
    func configurePriceChangeImage(for coin: ListModel) {
        guard let coinChange = coin.priceChangePercentage24H else { return }
        guard coinChange > 0 else {
            image = UIImage(systemName: "arrowtriangle.down.fill")
            tintColor = .systemRed
            return
        }
        image = UIImage(systemName: "arrowtriangle.up.fill")
        tintColor = .systemGreen
    }
}
