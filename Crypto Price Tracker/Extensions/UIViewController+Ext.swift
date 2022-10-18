//
//  UIViewController+Ext.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import UIKit

extension UIViewController {
    
    func presentCPAlertOnMainThread(title: String, message: String, buttonText: String) {
        DispatchQueue.main.async {
            let alertVC =  CPAlertViewController(title: title, message: message, buttonText: buttonText)
            alertVC.modalPresentationStyle = .automatic
            alertVC.modalTransitionStyle = .flipHorizontal
            self.present(alertVC, animated: true)
        }
    }
}


