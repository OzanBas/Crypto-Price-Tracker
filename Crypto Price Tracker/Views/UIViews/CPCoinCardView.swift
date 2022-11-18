//
//  CPCoinCardView.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 2.11.2022.
//

import UIKit

//MARK: - Protocol:FavoriteButtonProtocol
protocol FavoriteButtonProtocol {
    func didTapFavoriteButton(for coin: CoinModel)
}

//MARK: - Class:CPCoinCardView
final class CPCoinCardView: UIView {
    
//MARK: - Properties
    var buttonDelegate: FavoriteButtonProtocol?
    var coinDetails: CoinModel?
    
    private var coinLogoImageView = CPLogoImageView(frame: .zero)
    private var priceChangeImageView = UIImageView()
    private var coinPriceLabel = CPExplanatoryLabel()
    private var coinTitleLabel = CPNameLabel()
    private var coinPriceChangeLabel = CPNameLabel()
    var favoriteButton = CPFavoriteButton(frame: .zero)
    
    private let padding: CGFloat = 10
    private let paddingXL: CGFloat = 20
    private let paddingXS: CGFloat = 5
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(coinDetails: CoinModel) {
        self.init(frame: .zero)
        self.coinDetails = coinDetails
        setElements(coinDetails: coinDetails)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 //MARK: - Actions
    func setElements(coinDetails: CoinModel) {
        configurePriceChangeImage(for: coinDetails)
        configureStarImage()
        
        self.coinPriceLabel.text = coinDetails.marketData?.currentPrice?["usd"]?.formatToDisplayablePriceText()
        self.coinTitleLabel.text = coinDetails.name
        self.coinPriceChangeLabel.text = coinDetails.marketData?.priceChangePercentage24H?.formatToDisplayablePriceChangeText()
        if let coinImageUrl = coinDetails.image?.large {
                DispatchQueue.main.async {
                    self.coinLogoImageView.setImage(with: coinImageUrl)
            }
        }
    }
    
    @objc func favoriteButtonAction() {
        if let coinDetails = coinDetails {
            buttonDelegate?.didTapFavoriteButton(for: coinDetails)
        }
    }
//MARK: - Configuration
    private func configurePriceChangeImage(for coinDetails: CoinModel) {
        guard coinDetails.marketData?.priceChangePercentage24H ?? 1 > 0 else {
            priceChangeImageView.image = Images.priceChangeDown
            priceChangeImageView.tintColor = .systemRed
            return
        }
        priceChangeImageView.image = Images.priceChangeUp
        priceChangeImageView.tintColor = .systemGreen
    }
    
    
    private func configureStarImage() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let coins):
                if coins.contains(where: { $0.name == self.coinDetails?.name }) {
                    self.favoriteButton.configureForFavorite()
                } else {
                    self.favoriteButton.configureForNonFavorite()
                }
            case .failure(_):
                return
            }
        }
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 15
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        
        let priceChangeStackView = UIStackView(arrangedSubviews: [priceChangeImageView, coinPriceChangeLabel])
        let stackView = UIStackView(arrangedSubviews: [coinPriceLabel, priceChangeStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        priceChangeImageView.contentMode = .scaleAspectFit
        
        coinTitleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        coinTitleLabel.textAlignment = .left
        coinTitleLabel.adjustsFontSizeToFitWidth = true
        
        addSubviewsAndSetTamicToFalse(views: coinLogoImageView, favoriteButton, coinTitleLabel, stackView)
        
        NSLayoutConstraint.activate([
            coinLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            coinLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            coinLogoImageView.heightAnchor.constraint(equalToConstant: 80),
            coinLogoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            coinTitleLabel.topAnchor.constraint(equalTo: coinLogoImageView.topAnchor, constant: paddingXS),
            coinTitleLabel.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: paddingXL),
            coinTitleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -padding),
            coinTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            favoriteButton.centerYAnchor.constraint(equalTo: coinTitleLabel.centerYAnchor),
            favoriteButton.centerXAnchor.constraint(equalTo: priceChangeStackView.centerXAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            
            stackView.bottomAnchor.constraint(equalTo: coinLogoImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: paddingXL),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingXL),
            stackView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
