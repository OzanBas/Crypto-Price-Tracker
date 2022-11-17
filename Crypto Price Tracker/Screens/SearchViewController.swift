//
//  SearchViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

final class SearchViewController: CPDataRequesterVC {
    
    private var titleLabel: CPNameLabel!
    private var searchBar: UISearchBar!
    private var viewModel: SearchViewModel!
    private var cardView: CPCoinCardView?
    private var detailScrollView: CPDetailScrollView?
    private var emptyStateView: CPEmptyStateView!
    
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
    
    //MARK: - Actions
    private func requestNetworkCall(coinId: String) {
        
        
        viewModel.coinId = coinId
        
        showActivityIndicator()
        viewModel.getCoinDetails { [weak self] result in
            guard let self = self else { return }
            self.dismissActivityIndicator()
            switch result {
            case .success(_):
                self.removeCards()
                self.setUIElementsOnMainThread()
            case .failure(let error):
                self.presentCPAlertOnMainThread(title: "Requesting Error", message: error.rawValue, buttonText: "Ok")
            }
        }
    }
    
    
    private func createDismissKeyboardTapGesture(for view: UIView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Configurations
    private func removeCards() {
        DispatchQueue.main.async {
            self.cardView?.removeFromSuperview()
            self.detailScrollView?.removeFromSuperview()
        }
    }
    
    
    
    private func configureViewController() {
        self.title = "Search"
        view.backgroundColor = .systemBackground
        configureTitleLabel()
        configureSearchBar()
        configureEmptyStateView()
        createDismissKeyboardTapGesture(for: view)
      }
    
    
    private func setUIElementsOnMainThread() {
        DispatchQueue.main.async {
            self.configureCardView()
            self.configureDetailScrollView()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = CPNameLabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.text = "Search"
        
        view.addSubviewsAndSetTamicToFalse(views: titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureSearchBar() {
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
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func configureEmptyStateView() {
        emptyStateView = CPEmptyStateView(message: "Search for your gem.")
        emptyStateView.isHidden = false

        view.addSubviewsAndSetTamicToFalse(views: emptyStateView)
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    private func configureCardView() {
        cardView = CPCoinCardView(coinDetails: viewModel.coinDetails)
        cardView?.buttonDelegate = self
        
        guard let cardView = cardView else { return }
        view.addSubviewsAndSetTamicToFalse(views: cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    private func configureDetailScrollView() {
        detailScrollView = CPDetailScrollView(coinDetails: viewModel.coinDetails)
        detailScrollView?.setElements(coinDetails: viewModel.coinDetails)
        detailScrollView?.scrollViewButtonDelegate = self
        
        guard let detailScrollView = detailScrollView else { return }
        guard let cardView = cardView else { return }
        view.addSubviewsAndSetTamicToFalse(views: detailScrollView)
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 15),
            detailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


//MARK: - SearchBar+Ext
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
