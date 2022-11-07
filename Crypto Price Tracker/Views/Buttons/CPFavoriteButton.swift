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
    
    
    func configureEmptyStar() {
        backgroundColor = .systemGray6
        buttonImage.image = UIImage(systemName: "star")
        buttonImage.contentMode = .scaleAspectFill
        buttonImage.tintColor = .orange
    }
    
    
    func configureFilledStar() {
        backgroundColor = .systemGray6
        buttonImage.image = UIImage(systemName: "star.fill")
        buttonImage.contentMode = .scaleAspectFill
        buttonImage.tintColor = .orange
    }
    
}
