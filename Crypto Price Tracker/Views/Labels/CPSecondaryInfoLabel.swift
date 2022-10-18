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
}
