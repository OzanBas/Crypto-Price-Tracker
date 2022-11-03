//
//  CPFavoriteButton.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 31.10.2022.
//

import UIKit

class CPFavoriteButton: UIButton {
    
    var buttonImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        layer.cornerRadius = 10
        backgroundColor = .systemBackground
        layer.borderWidth = 0.5
        
        buttonImage = UIImageView(frame: .zero)
        addSubviewsAndSetTamicToFalse(views: buttonImage)
        buttonImage.image = UIImage(systemName: "star")
        buttonImage.tintColor = .orange
        buttonImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            buttonImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    
}
