//
//  CPSecondaryInfoLabel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class CPSecondaryInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        font = .systemFont(ofSize: 14)
        textColor = .secondaryLabel
        textAlignment = .left
    }
    
    
    func convertAndSetFromInt(from int: Int) {
        let convertedInt = String(int)
        self.text = convertedInt
    }
    
    
    func convertAndSetFromDouble(from double: Double) {
        let convertedDouble = String(double)
        self.text = convertedDouble
    }
}
