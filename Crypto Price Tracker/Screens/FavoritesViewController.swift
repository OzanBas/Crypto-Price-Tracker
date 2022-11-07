//
//  FavoritesViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 15.10.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    
//MARK: - Properties
    var viewModel: FavoritesViewModel!
    var tableView = UITableView()
    var padding: CGFloat = 10
    
    
    init(viewModel: FavoritesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        callForFavorites()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callForFavorites()
    }

    
    func callForFavorites() {
        viewModel.loadFavorites(completion: { [weak self] Result in
            guard let self = self else { return }
            switch Result {
            case.success(let coins):
                self.tableView.reloadData()
                print(coins.count)
            case.failure(let error):
                self.presentCPAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonText: "Ok")
            }
        })
    }
//MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
    }
    
    
    func configureTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = 110
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray5
        view.addSubviewsAndSetTamicToFalse(views: tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    
    }
}


//MARK: - TableView Extension
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.favoriteCoins.count)
        return viewModel.favoriteCoins.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        cell.coinDetails = viewModel.favoriteCoins[indexPath.row]
        cell.set()
        return cell
    }
}
