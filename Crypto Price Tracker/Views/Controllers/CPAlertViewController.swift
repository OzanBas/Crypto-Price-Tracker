//
//  CPAlertViewController.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import UIKit

class CPAlertViewController: UIViewController {

//MARK: - Properties
    private var containerView =  UIView()
    private var alertTitleLabel = CPNameLabel()
    private var alertInfoLabel = CPSecondaryInfoLabel()
    private var alertActionButton = UIButton(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureAlertTitle()
        configureAlertInfoLabel()
        configureAlertButton()
    }

    
    init(title: String, message: String, buttonText: String) {
        super.init(nibName: nil, bundle: nil)
        alertTitleLabel.text = title
        alertInfoLabel.text = message
        alertActionButton.setTitle(buttonText, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Actions
    @objc func dismissAlert() {
        self.dismiss(animated: true)
    }
    
//MARK: - Configuration
    func configureContainerView() {
        view.addSubviewsAndSetTamicToFalse(views: containerView)
        containerView.backgroundColor =  .systemGray5
        containerView.layer.borderWidth = 0.2
        containerView.layer.cornerRadius = 15

        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 180),
            containerView.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    
    func configureAlertTitle() {
        containerView.addSubviewsAndSetTamicToFalse(views: alertTitleLabel)
        
        
        NSLayoutConstraint.activate([
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            alertTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            alertTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            alertTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    
    func configureAlertInfoLabel() {
        
        containerView.addSubviewsAndSetTamicToFalse(views: alertInfoLabel)
        alertInfoLabel.numberOfLines = 3
        alertInfoLabel.textAlignment = .center
        

        NSLayoutConstraint.activate([
            alertInfoLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 10),
            alertInfoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            alertInfoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            alertInfoLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configureAlertButton() {
        containerView.addSubviewsAndSetTamicToFalse(views: alertActionButton)
        alertActionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        alertActionButton.backgroundColor = .systemRed
        alertActionButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        alertActionButton.layer.cornerRadius = 15
        alertActionButton.tintColor = .systemBackground
        
        NSLayoutConstraint.activate([
            alertActionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            alertActionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            alertActionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            alertActionButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
