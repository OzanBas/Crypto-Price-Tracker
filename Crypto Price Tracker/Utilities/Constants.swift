//
//  Constants.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 9.11.2022.
//

import UIKit

enum Images {
    
    static let placeHolderImage = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
    static let emptyStateSearch = UIImage(systemName: "waveform.and.magnifyingglass")
    static let priceChangeDown  = UIImage(systemName: "arrowtriangle.down.fill")
    static let priceChangeUp    = UIImage(systemName: "arrowtriangle.up.fill")
    static let nonFavorite      = UIImage(systemName: "star")
    static let favorite         = UIImage(systemName: "star.fill")
}

enum Endpoints {
    static let baseURL  = "https://api.coingecko.com/api/v3"
    static let list     = "/coins/markets?vs_currency=usd"
    static let coin     = "/coins/"
}
