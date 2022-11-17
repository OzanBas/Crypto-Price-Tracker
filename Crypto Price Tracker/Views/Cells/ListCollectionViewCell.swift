//
//  ListCollectionViewCell.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {
    
//MARK: - Properties
    private let service = NetworkManager()
    var network: NetworkManager?
    static let reuseId = "ListCollectionViewCell"
    
    private var cellContainerView = UIView()
    private var coinLogoImageView = CPLogoImageView(frame: .zero)
    private var coinNameLabel = CPNameLabel()
    private var priceLabel = CPSecondaryInfoLabel()
    private var priceChangePercentage = CPSecondaryInfoLabel()
    private var priceChangeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(network: NetworkManager) {
        self.init()
        self.network = network
    }
    
//MARK: - Actions
    func set(coin: ListModel) {
        coinNameLabel.text = coin.name
        
        
        priceLabel.text = coin.currentPrice?.formatToDisplayablePriceText()
        priceChangePercentage.text = coin.priceChangePercentage24H?.formatToDisplayablePriceChangeText()
        configurePriceChangeImage(for: coin)
        
        if let coinImage = coin.image {
            service.getCoinImage(for: coinImage) { image in
                DispatchQueue.main.async {
                    self.coinLogoImageView.image = image
                }
            }
        }
    }
    
//MARK: - Configuration
    func configurePriceChangeImage(for coin: ListModel) {
        if let coinPriceChange = coin.priceChangePercentage24H {
            guard coinPriceChange > 0 else {
                priceChangeImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
                priceChangeImageView.tintColor = .systemRed
                return
            }
            priceChangeImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            priceChangeImageView.tintColor = .systemGreen
            return
        }
    }
    
    func configureCellElements() {
        addSubviewsAndSetTamicToFalse(views: cellContainerView,
                                             coinLogoImageView,
                                             coinNameLabel,
                                             priceLabel,
                                             priceChangePercentage,
                                             priceChangeImageView)
        
        cellContainerView.layer.cornerRadius = 10
        cellContainerView.backgroundColor = .systemGray6
        
        
        let padding: CGFloat = 3
        NSLayoutConstraint.activate([
            
            cellContainerView.topAnchor.constraint(equalTo: topAnchor),
            cellContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            coinLogoImageView.topAnchor.constraint(equalTo: cellContainerView.topAnchor, constant: padding),
            coinLogoImageView.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor, constant: padding),
            coinLogoImageView.heightAnchor.constraint(equalToConstant: 65),
            coinLogoImageView.widthAnchor.constraint(equalToConstant: 65),
            
            coinNameLabel.topAnchor.constraint(equalTo: coinLogoImageView.bottomAnchor, constant: padding),
            coinNameLabel.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor, constant: padding),
            coinNameLabel.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor, constant: -padding),
            coinNameLabel.bottomAnchor.constraint(equalTo: cellContainerView.bottomAnchor, constant: -padding),
            
            priceLabel.centerYAnchor.constraint(equalTo: coinLogoImageView.centerYAnchor, constant: -15),
            priceLabel.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: padding * 4),
            priceLabel.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor, constant: -padding),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            priceChangeImageView.centerYAnchor.constraint(equalTo: coinLogoImageView.centerYAnchor, constant: 15),
            priceChangeImageView.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -3),
            priceChangeImageView.heightAnchor.constraint(equalToConstant: 15),
            priceChangeImageView.widthAnchor.constraint(equalToConstant: 15),
            
            priceChangePercentage.centerYAnchor.constraint(equalTo: coinLogoImageView.centerYAnchor, constant: 15),
            priceChangePercentage.leadingAnchor.constraint(equalTo: priceChangeImageView.trailingAnchor, constant: padding),
            priceChangePercentage.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor, constant: -padding),
            priceChangePercentage.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    
}
