//
//  UIViewController+Ext.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentCPAlertOnMainThread(title: String, message: String, buttonText: String) {
        DispatchQueue.main.async {
            let alertVC =  CPAlertViewController(title: title, message: message, buttonText: buttonText)
            alertVC.modalPresentationStyle = .popover
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func displayOnSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .orange
        present(safariVC, animated: true)
    }
    
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
        super.touchesEnded(touches, with: event)
    }
    
}


