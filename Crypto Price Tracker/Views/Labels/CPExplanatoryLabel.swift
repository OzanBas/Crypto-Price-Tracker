//
//  CPExplanatoryLabel.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 19.10.2022.
//

import UIKit

final class CPExplanatoryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(title: String, info: String) {
        let firstAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]
        let secondaryAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        
        let titleAttrText = NSAttributedString(string: title, attributes: firstAttribute)
        let infoAttrText = NSAttributedString(string: info, attributes: secondaryAttribute)
        
        let finalAttrText = NSMutableAttributedString()
        finalAttrText.append(titleAttrText)
        finalAttrText.append(infoAttrText)
        
        self.attributedText = finalAttrText
    }
}
