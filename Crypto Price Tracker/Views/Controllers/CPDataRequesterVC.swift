//
//  CPActivityIndicatorView.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 4.11.2022.
//

import UIKit

class CPDataRequesterVC: UIViewController {
    
    private var contentView: UIView!
    
    func showActivityIndicator() {
        
        contentView = UIView(frame: view.bounds)
        contentView.backgroundColor = .systemBackground
        contentView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {self.contentView.alpha = 0.8}
        
        view.addSubviewsAndSetTamicToFalse(views: contentView)
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        contentView.addSubviewsAndSetTamicToFalse(views: activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissActivityIndicator() {
        DispatchQueue.main.async {
            self.contentView.removeFromSuperview()
            self.contentView = nil
        }
    }
    
}
