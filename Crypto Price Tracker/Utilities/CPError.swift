//
//  CPError.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import Foundation


enum CPError: String, Error {
    
    case badEndpoint  = "Can not convert to a URL."
    case badResponse   = "Bad server response."
    case parsingError = "Can not parse JSON response."
    case dataError = "Invalid Data."
    
}
