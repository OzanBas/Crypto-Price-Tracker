//
//  SearchViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class SearchViewController: CPDataRequesterVC {

    
    var searchBar: UISearchBar!
    var viewModel: SearchViewModel!
    var titleLabel: CPNameLabel!
    var cardView: CPCoinCardView!
    var detailScrollView: CPDetailScrollView!
    var emptyStateView: CPEmptyStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    init(viewModel: SearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func requestNetworkCall(coinId: String) {
        viewModel.coinId = coinId
        
        showActivityIndicator()
        viewModel.getCoinDetails { [weak self] result in
            guard let self = self else { return }
            self.dismissActivityIndicator()
            switch result {
            case .success(let coinDetails):
                self.viewModel.coinDetails = coinDetails
                self.setUIElementsOnMainThread()
            case .failure(let error):
                self.presentCPAlertOnMainThread(title: "Requesting Error", message: error.rawValue, buttonText: "Ok")
            }
        }
    }
    
    
    
//MARK: - Configurations
    func configureViewController() {
        view.backgroundColor = .systemBackground
        configureTitleLabel()
        configureSearchBar()
        configureEmptyStateView()

    }
    
    func configureEmptyStateView() {
        emptyStateView = CPEmptyStateView(message: "Search for your gem.")
        view.addSubviewsAndSetTamicToFalse(views: emptyStateView)
        emptyStateView.isHidden = false
        
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    
    func configureTitleLabel() {
        titleLabel = CPNameLabel()
        view.addSubviewsAndSetTamicToFalse(views: titleLabel)
        titleLabel.text = "Search"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    
    func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.systemBackground.cgColor
        searchBar.tintColor = .orange
        searchBar.autocorrectionType = .no
        searchBar.placeholder = "Search for a coin"
        
        view.addSubviewsAndSetTamicToFalse(views: searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    


    func setUIElementsOnMainThread() {
        DispatchQueue.main.async {
            self.configureCardView()
            self.configureDetailScrollView()
        }
    }
    
    
    func configureCardView() {
        cardView = CPCoinCardView(coinDetails: viewModel.coinDetails)
        cardView.buttonDelegate = self
        view.addSubviewsAndSetTamicToFalse(views: cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureDetailScrollView() {
        detailScrollView = CPDetailScrollView(coinDetails: viewModel.coinDetails)
        detailScrollView.scrollViewButtonDelegate = self
        view.addSubviewsAndSetTamicToFalse(views: detailScrollView)
        detailScrollView.setElements(coinDetails: viewModel.coinDetails)
        
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 15),
            detailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.lowercased() else { return }
        emptyStateView.isHidden = true
        requestNetworkCall(coinId: text)
    }
    
    

}




//MARK: - DetailScrollViewButtonProtocol
extension SearchViewController: DetailScrollViewButtonProtocol {
    func didTapLinkButton(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.presentCPAlertOnMainThread(title: "Link Error", message: "Cannot move to url.", buttonText: "Ok")
            return
        }
        self.displayOnSafariVC(with: url)
    }
}
//MARK: - FavoriteButtonProtocol
extension SearchViewController: FavoriteButtonProtocol {
    func didTapFavoriteButton(for coin: CoinModel) {
        DispatchQueue.main.async { self.configureCardView() }
        
        PersistenceManager.update(favorite: coin) { error in
            guard let error = error else { return }
            self.presentCPAlertOnMainThread(title: "Note:", message: error.rawValue, buttonText: "Ok")
        }
    }
}
