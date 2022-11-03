//
//  Double+Ext.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 17.10.2022.
//

import Foundation

extension Double {
    
    
    func formatToDisplayablePriceChangeText() -> String {
        
        let newDouble =  self / 100
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .percent
        
        let enhancedPriceChangeString = formatter.string(from: newDouble as NSNumber) ?? "null"
        return enhancedPriceChangeString
    }
    
    
    func formatToDisplayablePriceText() -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 2
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        formatter.groupingSeparator = "."
        
        let enhancedPriceString = formatter.string(from: self as NSNumber) ?? "null"
        return enhancedPriceString
    }
    
    
    func formatToThousandSeparatedText() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        
        let enhancedPriceString = formatter.string(from: self as NSNumber) ?? "null"
        return enhancedPriceString
        
    }
    
}
