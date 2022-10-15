//
//  ListViewModel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit


class ListViewModel {
    
    
    func setSearchController(listVC: ListViewController) -> UISearchController {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Filter results"
        searchController.searchResultsUpdater = listVC
        searchController.obscuresBackgroundDuringPresentation =  false
        
        listVC.navigationItem.searchController = searchController
        return searchController
    }
    
    
    func configureCollectionView() {
        
    }
}
