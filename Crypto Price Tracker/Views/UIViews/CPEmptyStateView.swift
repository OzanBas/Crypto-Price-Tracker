//
//  CPEmptyStateView.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 8.11.2022.
//

import UIKit


class CPEmptyStateView: UIView {
    
    let messageLabel = CPNameLabel()
    let logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    convenience init(message: String, image: UIImage) {
        self.init(frame: .zero)
        messageLabel.text = message
        logoImageView.image = image
    }
    
    func configure() {
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        addSubviewsAndSetTamicToFalse(views: messageLabel)
        messageLabel.font = .systemFont(ofSize: 25, weight: .bold)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImageView() {
        addSubviewsAndSetTamicToFalse(views: logoImageView)
        var width: CGFloat { return UIScreen.main.bounds.width }
        var height: CGFloat { return UIScreen.main.bounds.width }

        logoImageView.image = Images.emptyStateSearch
        logoImageView.tintColor = .orange
        logoImageView.backgroundColor = .systemBackground
        logoImageView.contentMode = .scaleAspectFit

        
        NSLayoutConstraint.activate([
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -height / 5),
            logoImageView.heightAnchor.constraint(equalToConstant: height / 2),
            logoImageView.widthAnchor.constraint(equalToConstant: width / 1.5)
        ])
    }
}
