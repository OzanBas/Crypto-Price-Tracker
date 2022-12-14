//
//  DetailCoinViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit

class DetailCoinViewController: CPDataRequesterVC {
    
    //MARK: - Properties
    var viewModel: DetailCoinViewModel!
    var topCardView: CPCoinCardView!
    var detailCardView: CPDetailScrollView!
    

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        requestCoinDetails()
    }
    
    
    init(viewModel: DetailCoinViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//MARK: - Actions
    func requestCoinDetails() {
        showActivityIndicator()
        viewModel.requestCoinDetails { [weak self] result in
            self?.dismissActivityIndicator()
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.setCardElements(with: self.viewModel.coinDetail)
            case .failure(let error):
                self.presentCPAlertOnMainThread(title: "Can't display info", message: error.rawValue, buttonText: "Ok")
            }
        }
    }
    
    func setCardElements(with coin: CoinModel) {
        DispatchQueue.main.async {
            self.configureTopCard()
            self.configureDetailsCard()
        }
    }
    
    
//MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    func configureTopCard() {
        topCardView = CPCoinCardView(coinDetails: viewModel.coinDetail)
        topCardView.buttonDelegate = self
        view.addSubviewsAndSetTamicToFalse(views: topCardView)
        
        NSLayoutConstraint.activate([
            topCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topCardView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    func configureDetailsCard() {
        detailCardView = CPDetailScrollView(coinDetails: viewModel.coinDetail)
        detailCardView.scrollViewButtonDelegate = self
        view.addSubviewsAndSetTamicToFalse(views: detailCardView)
        detailCardView.setElements(coinDetails: viewModel.coinDetail)
        
        NSLayoutConstraint.activate([
            detailCardView.topAnchor.constraint(equalTo: topCardView.bottomAnchor, constant: 15),
            detailCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - DetailScrollViewButtonProtocol
extension DetailCoinViewController: DetailScrollViewButtonProtocol {
    func didTapLinkButton(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.presentCPAlertOnMainThread(title: "Link Error", message: "Cannot move to url.", buttonText: "Ok")
            return
        }
        self.displayOnSafariVC(with: url)
    }
}


//MARK: - FavoriteButtonProtocol
extension DetailCoinViewController: FavoriteButtonProtocol {
    func didTapFavoriteButton(for coin: CoinModel) {
        DispatchQueue.main.async { self.configureTopCard() }
        
        PersistenceManager.update(favorite: coin) { error in
            guard let error = error else { return }
            self.presentCPAlertOnMainThread(title: "Note:", message: error.rawValue, buttonText: "Ok")
        }
    }
}

