//
//  DetailCoinViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit

class DetailCoinViewController: UIViewController {

    var coinLogoImageView = CPLogoImageView(frame: .zero)
    var priceChangeImageView = UIImageView()
    var coinPriceLabel = CPExplanatoryLabel()
    var coinTitleLabel = CPNameLabel()
    var coinPriceChangeLabel = CPNameLabel()
    var favoriteButton = UIButton()
    
    private var staticDetailsLabel = CPNameLabel()
    private var staticDescriptionLabel = CPNameLabel()
    var descriptionLabel = CPSecondaryInfoLabel()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureExp()
    }


    
    func configureExp() {
        
        view.addSubviewsAndSetTamicToFalse(views: coinPriceLabel)
        
        coinPriceLabel.configure(title: "deneme: ", info: "15000")
        
        NSLayoutConstraint.activate([
            coinPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinPriceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coinPriceLabel.heightAnchor.constraint(equalToConstant: 50),
            coinPriceLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
}
