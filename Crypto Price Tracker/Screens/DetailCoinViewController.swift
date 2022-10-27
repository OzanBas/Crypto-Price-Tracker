//
//  DetailCoinViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit

class DetailCoinViewController: UIViewController {

//MARK: - Properties
    var viewModel: DetailCoinViewModel!
    
    var coinLogoImageView = CPLogoImageView(frame: .zero)
    var priceChangeImageView = UIImageView()
    var coinPriceLabel = CPExplanatoryLabel()
    var coinTitleLabel = CPNameLabel()
    var coinPriceChangeLabel = CPNameLabel()
    var favoriteButton = UIButton()
    
    private var staticDetailsLabel = CPNameLabel()
    private var staticDescriptionLabel = CPNameLabel()
    var descriptionLabel = CPSecondaryInfoLabel()

    private var padding: CGFloat = 10
    private var paddingXS: CGFloat = 5
    private var paddingXL: CGFloat = 20
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTopSide()
        viewModel.setVCElements(for: self)
        
    }


    init(viewModel: DetailCoinViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - Configuration
    func configureTopSide() {
        
        let stackView = UIStackView(arrangedSubviews: [coinPriceLabel, priceChangeImageView, coinPriceChangeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        view.addSubviewsAndSetTamicToFalse(views: coinLogoImageView, favoriteButton, coinTitleLabel, stackView)
        
        
        NSLayoutConstraint.activate([
            coinLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            coinLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            coinLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            coinLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.topAnchor.constraint(equalTo: coinLogoImageView.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            favoriteButton.heightAnchor.constraint(equalToConstant: 45),
            favoriteButton.widthAnchor.constraint(equalToConstant: 45),
            
            coinTitleLabel.topAnchor.constraint(equalTo: coinLogoImageView.topAnchor),
            coinTitleLabel.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: paddingXS),
            coinTitleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: paddingXS),
            coinTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            stackView.bottomAnchor.constraint(equalTo: coinLogoImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: coinLogoImageView.trailingAnchor, constant: paddingXS),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    
}
