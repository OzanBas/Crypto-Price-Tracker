//
//  CPFavoriteButton.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 31.10.2022.
//

import UIKit

final class CPFavoriteButton: UIButton {
    
    private var buttonImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        buttonImage = UIImageView(frame: .zero)
        addSubviewsAndSetTamicToFalse(views: buttonImage)
        NSLayoutConstraint.activate([
            buttonImage.topAnchor.constraint(equalTo: topAnchor),
            buttonImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func configureForNonFavorite() {
        backgroundColor = .systemGray6
        buttonImage.image = Images.nonFavorite
        buttonImage.contentMode = .scaleAspectFill
        buttonImage.tintColor = .orange
    }
    
    
    func configureForFavorite() {
        backgroundColor = .systemGray6
        buttonImage.image = Images.favorite
        buttonImage.contentMode = .scaleAspectFill
        buttonImage.tintColor = .orange
    }
    
}
