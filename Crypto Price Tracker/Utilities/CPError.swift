//
//  CPError.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


enum CPError: String, Error {
    
    case NoInternetConnection = "Can not send request. Check your internet connection."
    case badEndpoint  = "Can not convert to a URL."
    case badResponse   = "Unexpected server response. Please try again later."
    case parsingError = "Can not parse JSON. Server response might be changed or something is broken."
    case dataError = "Invalid Data. Immediately throw your phone out of the closest window."
    
    case savingError = "Cannot add this coin to your favorites list. Please try again later."
    case retrievingFavorites = "Cannot get your favorite coins. Maybe you never liked them at all!"
}
