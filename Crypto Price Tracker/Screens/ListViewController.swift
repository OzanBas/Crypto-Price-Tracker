//
//  ListViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class ListViewController: UIViewController {

//MARK: - Properties
    var viewModel: ListViewModel!
    var searchController: UISearchController!
    var collectionView: UICollectionView!
    
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        viewModel.getCoinsList(present: self)
        collectionView.delegate = self
    }

    
    init(viewModel: ListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        searchController = viewModel.setSearchController(listVC: self)
        searchController.delegate = self
        configureCollectionView()
    }
      
    
    func configureCollectionView() {
        collectionView = viewModel.configureCollectionView(for: view)
        viewModel.configureDataSource(collectionView: collectionView)
        view.addSubview(collectionView)
    }
}

//MARK: - Ext+SearchController
extension ListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let coins = viewModel.coins
        guard let filter = searchController.searchBar.text, !filter.isEmpty == true else {
            viewModel.updateData(with: coins)
            return }
        let filteredCoins = coins.filter { $0.name.lowercased().contains(filter.lowercased()) }
        viewModel.updateData(with: filteredCoins)
    }
}

//MARK: - Ext+CollectionView
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailCoinViewController()
        detailVC.title =  viewModel.coins[indexPath.row].name
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
