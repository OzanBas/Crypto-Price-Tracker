//
//  ListViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class ListViewController: CPDataRequesterVC {

//MARK: - Properties
    var viewModel: ListViewModel!
    var searchController: UISearchController!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ListModel>!

    enum Section {
        case main
    }
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        requestFirstTimeNetworkCall()
    }

    
    init(viewModel: ListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//MARK: - Actions
    func updateData(with coins: [ListModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(coins)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    func requestFirstTimeNetworkCall() {
        showActivityIndicator()
        viewModel.getCoinsList { [weak self] result in
            guard let self = self else { return }
            self.dismissActivityIndicator()
            switch result {
            case .success(let coins):
                self.updateData(with: coins)
            case .failure(let error):
                self.presentCPAlertOnMainThread(title: "No Internet Connection", message: error.rawValue, buttonText: "Ok")
            }
        }
    }
    
    
//MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        searchController = configureSearchController()
        configureCollectionView()
    }
      
    
    func configureCollectionView() {
        let collectionView =  UICollectionView(frame: view.bounds, collectionViewLayout: twoColumnFlowLayout(for: view))
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseId)
        collectionView.delegate = self
        configureDataSource(collectionView: collectionView)
        view.addSubview(collectionView)
        
    }
    
    
    func twoColumnFlowLayout(for view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - itemSpacing
        let cellWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth - 55)
        return flowLayout
    }

    
    func configureSearchController() -> UISearchController {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Filter results"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation =  false
        searchController.delegate = self
        navigationItem.searchController = searchController
        return searchController
    }
    
    
    func configureDataSource(collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, ListModel>(collectionView: collectionView , cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseId, for: indexPath) as! ListCollectionViewCell
            guard self.searchController.searchBar.text == "" else {
                cell.set(coin: self.viewModel.filteredCoins[indexPath.item])
                return cell
            }
            cell.set(coin: self.viewModel.coins[indexPath.item])
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
        viewModel.filteredCoins = coins.filter { $0.name.lowercased().contains(searchText.lowercased())
        }
        updateData(with: viewModel.filteredCoins)
    }
}


//MARK: - Ext+CollectionView
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard viewModel.filteredCoins.count == 0 else {
            let coinId = viewModel.filteredCoins[indexPath.row].id.lowercased()
            let detailViewModel = DetailCoinViewModel(coinId: coinId)
            let detailVC = DetailCoinViewController(viewModel: detailViewModel)
            detailVC.title =  viewModel.filteredCoins[indexPath.row].name
            self.navigationController?.pushViewController(detailVC, animated: true)
            return
        }
        let coinId = viewModel.coins[indexPath.row].id.lowercased()
        let detailViewModel = DetailCoinViewModel(coinId: coinId)
        let detailVC = DetailCoinViewController(viewModel: detailViewModel)
        detailVC.title =  viewModel.coins[indexPath.row].name
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
