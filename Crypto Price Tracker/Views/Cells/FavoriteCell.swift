//
//  CPFavoriteCell.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 4.11.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseId = "FavoriteCell"
    var coinDetails: CoinModel!
    
    private var containerView: UIView!
    private var cardView: CPCoinCardView!
    private var padding: CGFloat = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func set() {
        containerView = UIView()
        cardView = CPCoinCardView(coinDetails: coinDetails)
        addSubviewsAndSetTamicToFalse(views: containerView)
        containerView.addSubviewsAndSetTamicToFalse(views: cardView)

        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding * 2),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding * 2),
            cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding)
        ])
        
    }

}
