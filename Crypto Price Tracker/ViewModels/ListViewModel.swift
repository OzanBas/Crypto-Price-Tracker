//
//  ListViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit


class ListViewModel {
    
    let service = NetworkManager()
    var coins: [ListModel] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, ListModel>!
    
    
    enum Section {
        case main
    }
    
    
    func getCoinsList(present VC: ListViewController) {
        
        Task{
            do {
                let coins = try await service.getCoinsList()
                self.coins = coins
                updateData(with: coins)
            } catch {
                if let cpError = error as? CPError {
                    await VC.presentCPAlertOnMainThread(title: "Something Went Wrong", message: cpError.rawValue, buttonText: "OK")
                }
            }
        }
    }
    
    
    func setSearchController(listVC: ListViewController) -> UISearchController {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Filter results"
        searchController.searchResultsUpdater = listVC
        searchController.obscuresBackgroundDuringPresentation =  false
        
        listVC.navigationItem.searchController = searchController
        return searchController
    }
    
    
    func configureCollectionView(for view: UIView) -> UICollectionView {
        let collectionView =  UICollectionView(frame: view.bounds, collectionViewLayout: twoColumnFlowLayout(for: view))
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseId)
        
        return collectionView
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
    
    
    func configureDataSource(collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<Section, ListModel>(collectionView: collectionView , cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseId, for: indexPath) as! ListCollectionViewCell
                cell.set(coin: self.coins[indexPath.item])
            return cell
        })
    }
    
    
    func updateData(with coins: [ListModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(coins)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    
}
