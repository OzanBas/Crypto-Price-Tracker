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
    var emptyStateView: CPEmptyStateView!
    
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
        configureEmptyStateView()

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
            case.success(_):
                DispatchQueue.main.async { self.tableView.reloadData() }
            case.failure(let error):
                self.presentCPAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonText: "Ok")
            }
        })
    }
//MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
    }
    
    
    func configureEmptyStateView() {
        guard let image = UIImage(systemName: "list.star") else { return }
        let message = "Your favorites list is empty."
        
        
        emptyStateView = CPEmptyStateView(message: message, image: image)
        emptyStateView.backgroundColor = .systemBackground
        view.addSubviewsAndSetTamicToFalse(views: emptyStateView)
        
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 110
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
        let count = viewModel.favoriteCoins.count
        if count == 0 { emptyStateView.isHidden = false } else { emptyStateView.isHidden = true }
        return count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        cell.coinDetails = viewModel.favoriteCoins[indexPath.row]
        cell.set()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coinId = viewModel.favoriteCoins[indexPath.row].id {
            
            let detailVC = DetailCoinViewController(viewModel: DetailCoinViewModel(coinId: coinId))
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = viewModel.favoriteCoins[indexPath.row]
        
        PersistenceManager.update(favorite: favorite) { [weak self] error in
            guard let self = self else { return }
            self.presentCPAlertOnMainThread(title: "Deleting Error", message: error?.rawValue ?? "error", buttonText: "Ok")
        }
        self.callForFavorites()
        self.tableView.reloadData()
        
    }
}
