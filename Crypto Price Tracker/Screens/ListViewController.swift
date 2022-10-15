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
    var collectionView: UICollectionView?
    
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureProperties()
    }

    init(viewModel: ListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Configuration
    func configureProperties() {
        searchController = viewModel.setSearchController(listVC: self)
    }
    
    
    
//MARK: - UILayout

}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    
}
