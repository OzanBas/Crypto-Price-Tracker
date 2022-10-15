//
//  ListCollectionViewCell.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ListCollectionViewCell"
    
    private var coinLogoImageView = CPLogoImageView(frame: .zero)
    private var coinNameLabel = CPNameLabel()
    private var priceLabel = CPSecondaryInfoLabel()
    private var priceChangePercentage = CPSecondaryInfoLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(coin: ListModel) {
        self.coinNameLabel.text = coin.name
        self.priceLabel.convertAndSetFromDouble(from: coin.currentPrice)
        self.priceChangePercentage.convertAndSetFromDouble(from: coin.priceChangePercentage24H)
    }
    
    
    func configure() {
        addSubviewsAndSetTamicToFalse(views: coinLogoImageView, coinNameLabel, priceLabel, priceChangePercentage)

        
        let padding: CGFloat = 3
        NSLayoutConstraint.activate([
            coinLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            coinLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            coinLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            coinLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            
            coinNameLabel.topAnchor.constraint(equalTo: coinLogoImageView.bottomAnchor, constant: padding),
            coinNameLabel.leadingAnchor.constraint(equalTo: coinLogoImageView.leadingAnchor, constant: padding),
            coinNameLabel.trailingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: -padding),
            coinNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            priceLabel.centerYAnchor.constraint(equalTo: coinLogoImageView.centerYAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            priceChangePercentage.centerYAnchor.constraint(equalTo: coinLogoImageView.centerYAnchor, constant: -20),
            priceChangePercentage.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: padding),
            priceChangePercentage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            priceChangePercentage.heightAnchor.constraint(equalToConstant: 24),
        ])
        
    }
    
}
