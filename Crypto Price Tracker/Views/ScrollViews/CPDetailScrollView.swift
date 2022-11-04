//
//  CPDetailScrollView.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 2.11.2022.
//

import UIKit

protocol DetailScrollViewButtonProtocol {
    func didTapLinkButton(urlString: String)
}


final class CPDetailScrollView: UIScrollView {
    
    var scrollViewButtonDelegate: DetailScrollViewButtonProtocol?
    var coinDetails: CoinModel!
    var contentView = UIView()
    var cardView = UIView()
    
    private let padding: CGFloat = 10
    private let paddingXL: CGFloat = 20
    
    private var marketCapRankTitle          = CPNameLabel()
    private var volumeTitleLabel            = CPNameLabel()
    private var circulationTitleLabel       = CPNameLabel()
    private var totalCapTitleLabel          = CPNameLabel()
    private var athTitleLabel               = CPNameLabel()
    private var homePageLinkTitleLabel      = CPNameLabel()
    
    private var marketCapRankLabel          = CPSecondaryInfoLabel()
    private var volumeLabel                 = CPSecondaryInfoLabel()
    private var circulationLabel            = CPSecondaryInfoLabel()
    private var totalCapLabel               = CPSecondaryInfoLabel()
    private var athLabel                    = CPSecondaryInfoLabel()
    private var linkButton                  = UIButton(frame: .zero)
    private var descriptionTitleLabel       = CPNameLabel()
    private var descriptionLabel            = CPSecondaryInfoLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
        configureCardView()
        configureStaticLabels()
        configureInfoLabels()
    }
    
    convenience init(coinDetails: CoinModel) {
        self.init()
        self.coinDetails = coinDetails
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setElements(coinDetails: CoinModel) {
        marketCapRankLabel.text = coinDetails.marketCapRank?.formatted()
        let volume = coinDetails.marketData.totalVolume?["usd"]?.formatToDisplayablePriceText()
        let circulation = coinDetails.marketData.circulatingSupply?.formatToThousandSeparatedText()
        let totalCap = coinDetails.marketData.totalSupply?.formatToThousandSeparatedText()
        let ath = coinDetails.marketData.ath?["usd"]?.formatToDisplayablePriceText()
        let urlString = coinDetails.links.homepage?[0]
        
        volumeLabel.text = volume
        circulationLabel.text = circulation
        totalCapLabel.text = totalCap
        athLabel.text = ath
        linkButton.setTitle(urlString, for: .normal)
        descriptionTitleLabel.text = "Description"
        descriptionLabel.text = coinDetails.description?.en
    }

    
    fileprivate func configureContentView() {
        addSubviewsAndSetTamicToFalse(views: contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    fileprivate func configureCardView() {
        contentView.addSubviewsAndSetTamicToFalse(views: cardView)
        cardView.backgroundColor = .systemGray6
        cardView.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingXL),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingXL),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddingXL)
        ])
    }
    
    
    fileprivate func configureStaticLabels() {
        marketCapRankTitle.text         = "Market Rank: "
        volumeTitleLabel.text           = "Volume: "
        circulationTitleLabel.text      = "Circulation: "
        totalCapTitleLabel.text         = "Total Supply: "
        athTitleLabel.text              = "All time high: "
        homePageLinkTitleLabel.text     = "Links: "
        
        marketCapRankTitle.textAlignment        = .left
        volumeTitleLabel.textAlignment          = .left
        circulationTitleLabel.textAlignment     = .left
        totalCapTitleLabel.textAlignment        = .left
        athTitleLabel.textAlignment             = .left
        homePageLinkTitleLabel.textAlignment    = .left
        
        cardView.addSubviewsAndSetTamicToFalse(views: marketCapRankTitle, volumeTitleLabel,circulationTitleLabel, totalCapTitleLabel, athTitleLabel, homePageLinkTitleLabel)
        
        NSLayoutConstraint.activate([
            marketCapRankTitle.topAnchor.constraint(equalTo: cardView.topAnchor, constant: paddingXL),
            marketCapRankTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            marketCapRankTitle.widthAnchor.constraint(equalToConstant: 110),
            marketCapRankTitle.heightAnchor.constraint(equalToConstant: 22),
            
            athTitleLabel.topAnchor.constraint(equalTo: marketCapRankTitle.bottomAnchor, constant: padding),
            athTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            athTitleLabel.widthAnchor.constraint(equalToConstant: 110),
            athTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            volumeTitleLabel.topAnchor.constraint(equalTo: athTitleLabel.bottomAnchor, constant: padding),
            volumeTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            volumeTitleLabel.widthAnchor.constraint(equalToConstant: 110),
            volumeTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            circulationTitleLabel.topAnchor.constraint(equalTo: volumeTitleLabel.bottomAnchor, constant: padding),
            circulationTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            circulationTitleLabel.widthAnchor.constraint(equalToConstant: 110),
            circulationTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            totalCapTitleLabel.topAnchor.constraint(equalTo: circulationTitleLabel.bottomAnchor, constant: padding),
            totalCapTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            totalCapTitleLabel.widthAnchor.constraint(equalToConstant: 110),
            totalCapTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            homePageLinkTitleLabel.topAnchor.constraint(equalTo: totalCapTitleLabel.bottomAnchor, constant: padding),
            homePageLinkTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            homePageLinkTitleLabel.widthAnchor.constraint(equalToConstant: 110),
            homePageLinkTitleLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
        
    }
    
    fileprivate func configureInfoLabels() {

        linkButton.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
        linkButton.setTitleColor(.blue, for: .normal)
        linkButton.setTitleColor(.purple, for: .highlighted)
        linkButton.titleLabel?.font = .systemFont(ofSize: 12)
        linkButton.contentHorizontalAlignment = .left

        
        descriptionLabel.numberOfLines = 0
        cardView.addSubviewsAndSetTamicToFalse(views: marketCapRankLabel, volumeLabel, circulationLabel, totalCapLabel, athLabel, linkButton, descriptionTitleLabel, descriptionLabel)
        
        
        
        NSLayoutConstraint.activate([
            marketCapRankLabel.centerYAnchor.constraint(equalTo: marketCapRankTitle.centerYAnchor),
            marketCapRankLabel.leadingAnchor.constraint(equalTo: marketCapRankTitle.trailingAnchor, constant: padding),
            marketCapRankLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            marketCapRankLabel.heightAnchor.constraint(equalToConstant: 22),
            
            volumeLabel.centerYAnchor.constraint(equalTo: volumeTitleLabel.centerYAnchor),
            volumeLabel.leadingAnchor.constraint(equalTo: volumeTitleLabel.trailingAnchor, constant: padding),
            volumeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            volumeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            athLabel.centerYAnchor.constraint(equalTo: athTitleLabel.centerYAnchor),
            athLabel.leadingAnchor.constraint(equalTo: athTitleLabel.trailingAnchor, constant: padding),
            athLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            athLabel.heightAnchor.constraint(equalToConstant: 22),
            
            circulationLabel.centerYAnchor.constraint(equalTo: circulationTitleLabel.centerYAnchor),
            circulationLabel.leadingAnchor.constraint(equalTo: circulationTitleLabel.trailingAnchor, constant: padding),
            circulationLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            circulationLabel.heightAnchor.constraint(equalToConstant: 22),
            
            totalCapLabel.centerYAnchor.constraint(equalTo: totalCapTitleLabel.centerYAnchor),
            totalCapLabel.leadingAnchor.constraint(equalTo: totalCapTitleLabel.trailingAnchor, constant: padding),
            totalCapLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            totalCapLabel.heightAnchor.constraint(equalToConstant: 22),
            
            linkButton.centerYAnchor.constraint(equalTo: homePageLinkTitleLabel.centerYAnchor),
            linkButton.leadingAnchor.constraint(equalTo: homePageLinkTitleLabel.trailingAnchor, constant: padding),
            linkButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            linkButton.heightAnchor.constraint(equalToConstant: 22),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: paddingXL),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            descriptionTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: paddingXL),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -paddingXL),
            descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -paddingXL)
        ])
    }
    
    @objc func goToLink() {
        scrollViewButtonDelegate?.didTapLinkButton(urlString: linkButton.titleLabel?.text ?? "null")
    }
    
}
