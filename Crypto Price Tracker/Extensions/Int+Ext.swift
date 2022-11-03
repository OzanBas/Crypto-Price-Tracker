//
//  Int+Ext.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 3.11.2022.
//

import Foundation

extension Int {
    
    func formatToThousandSeparatedText() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .none
        formatter.groupingSeparator = "."
        
        let enhancedPriceString = formatter.string(from: self as NSNumber) ?? "null"
        return enhancedPriceString
        
    }
}
