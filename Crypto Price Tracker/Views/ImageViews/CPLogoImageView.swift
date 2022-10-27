//
//  CPLogoImageView.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class CPLogoImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius =  10
        tintColor = .orange
        image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
        
    }
}
