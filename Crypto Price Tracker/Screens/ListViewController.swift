//
//  ListViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

final class ListViewController: CPDataRequesterVC {

//MARK: - Properties
    private let viewModel: ListViewModel!
    private var searchController: UISearchController!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ListModel>!


    enum Section {
        case main
    }
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        requestNetworkCall()
    }

    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//MARK: - Actions
    private func updateData(with coins: [ListModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(coins)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func requestNetworkCall() {
        showActivityIndicator()
        viewModel.getCoinsList { [weak self] result in
            guard let self = self else { return }
            self.dismissActivityIndicator()
            switch result {
            case .success(_):
                self.updateData(with: self.viewModel.coins)
            case .failure(let error):
                self.presentCPAlertOnMainThread(title: "No Internet Connection", message: error.rawValue, buttonText: "Ok")
            }
        }
    }

    
    func navigateToDetailVC(coin: ListModel) {
        guard let coinId = coin.id else { return }
        let detailViewModel = DetailCoinViewModel(coinId: coinId.lowercased())
        let detailVC = DetailCoinViewController(viewModel: detailViewModel)
        detailVC.title = coin.name
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchController.searchBar.endEditing(true)
    }

//MARK: - Configuration
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        searchController = configureSearchController()
        configureCollectionView()
        createDismissKeyboardTapGesture()
    }
      
    
    private func configureCollectionView() {
        let collectionView =  UICollectionView(frame: view.bounds, collectionViewLayout: twoColumnFlowLayout(for: view))
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseId)
        collectionView.delegate = self
        
        configureDataSource(collectionView: collectionView)
        view.addSubview(collectionView)
        
    }
    
    
    private func configureSearchController() -> UISearchController {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Filter results"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation =  false
        searchController.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    }
    
    
    private func configureDataSource(collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, ListModel>(collectionView: collectionView , cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseId, for: indexPath) as! ListCollectionViewCell
            
            let isNotFiltered = self.searchController.searchBar.text == ""
            let coin = isNotFiltered ? self.viewModel.coins[indexPath.item] : self.viewModel.filteredCoins[indexPath.item]
            
            cell.set(coin: coin)
            
            return cell
        })
    }
}


//MARK: - Ext+SearchController
extension ListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let coins = viewModel.coins
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty == true else {
            viewModel.filteredCoins.removeAll()
            updateData(with: coins)
            return }

        viewModel.filteredCoins = coins.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        updateData(with: viewModel.filteredCoins)
    }
}


//MARK: - Ext+CollectionView
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let isNotFiltered = viewModel.filteredCoins.count == 0
        let coin = isNotFiltered ? viewModel.coins[indexPath.row] : viewModel.filteredCoins[indexPath.row]
        
        navigateToDetailVC(coin: coin)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y                // shows how much you scrolled down
        let contentHeight = scrollView.contentSize.height       // shows initial content height
        let height = scrollView.frame.size.height               // height of scrollview for current device
        
        if offsetY > contentHeight - height {
            guard viewModel.moreCoinsAvailable, !viewModel.isLoadingMoreCoins else { return }
            viewModel.page += 1
            requestNetworkCall()
            
        }
    }
}

