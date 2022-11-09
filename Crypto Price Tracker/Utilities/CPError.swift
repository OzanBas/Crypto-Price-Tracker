//
//  CPError.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


enum CPError: String, Error {
    
    case NoInternetConnection   = "Can not send request. Check your internet connection."
    case badEndpoint            = "Can not convert to an URL."
    case badResponse            = "Unexpected server response. Please try again later."
    case parsingError           = "Can not parse JSON. Server response might be changed or something is broken."
    case dataError              = "Invalid Data. Smash your phone with a hammer and try again."
    
    case savingError            = "Can't add this coin to your favorites list. Please try again later."
    case retrievingFavorites    = "Can't get your favorite coins."
    case removingAlert          = "This coin will be removed from your favorites."
    case addingAlert            = "This coin will be added to your favorites."
}
