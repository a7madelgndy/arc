//
//  AlertVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView = ContainerView()
    let titleLabel    = TitleLabel(textAlignment: .center, fontsize: 20)
    let messageLabel  = BodyLabel(textAlignment: .center)
    let actionButton  = MainButton(color: .systemPurple, title: "OK", systemNameImage: "checkmark.circle")
    
    var alerTitle : String?
    var message: String?
    var buttonTitle : String?
    
    let padding : CGFloat = 20
    
    init(title: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alerTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubViews(containerView ,titleLabel ,actionButton,messageLabel)
        
        configerContainerView()
        configerTitleLable()
        configerActionButton()
        configerMessageLabel()
        
    }
    

    func configerContainerView(){
    
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configerTitleLable() {
        titleLabel.text = alerTitle ?? "someting Went Wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor , constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configerActionButton() {
        actionButton.setTitle(buttonTitle ?? "ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate(
        [
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        )
    }
    
    
    func configerMessageLabel() {
        messageLabel.text = message ?? "unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor,constant: -5),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor  , constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant : -padding)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true )
    }
}



