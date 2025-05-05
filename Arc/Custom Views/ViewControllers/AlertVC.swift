//
//  AlertVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//

import UIKit

protocol CancelButtonProtocol:AnyObject {
    func didTappedOkButton(withIndexpath: Int)
}


class AlertVC: UIViewController {
    //MARK: Properties
    let actionStackView = UIStackView()
    
    let containerView = ContainerView()
    let titleLabel    = TitleLabel(textAlignment: .center, fontsize: 20)
    let messageLabel  = BodyLabel(textAlignment: .center)
    let okActionButton  = MainButton(systemNameImage: SFSymbols.checkmarkCircle, foregroundcolor: Colors.main)
    lazy var cancelActionButton = MainButton(systemNameImage: SFSymbols.xmarkCircle, title : "cancel", foregroundcolor: .systemRed)
    
    var alerTitle : String?
    var message: String?
    var okButtonTitle : String?
    
    var didAddCancelButton = false
    
    var didTappedCancelButton = false
    
    weak var delegate: CancelButtonProtocol?
    var indexPath: Int?
    
    let padding : CGFloat = 20
    
    init(title: String? = nil, message: String? = nil, okButtonTitle: String? = nil, addCancelButton: Bool = false ) {
        super.init(nibName: nil, bundle: nil)
        self.alerTitle = title
        self.message = message
        self.okActionButton.configuration?.title = okButtonTitle
        
        if addCancelButton {
            didAddCancelButton = true
        }

    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuerUI()
    }
    
    //MARK: Configuertion
    func configuerUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubViews(containerView ,titleLabel ,actionStackView ,messageLabel)
        
        configerContainerView()
        configerTitleLable()
        configerActionStackView()
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
    
    
    func configerActionStackView() {
        actionStackView.axis = .horizontal
        actionStackView.distribution = .equalSpacing
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        actionStackView.addArrangedSubview(okActionButton)
        NSLayoutConstraint.activate([
            okActionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        if didAddCancelButton {
            actionStackView.spacing = 10
            actionStackView.addArrangedSubview(cancelActionButton)
            cancelActionButton.addTarget(self, action: #selector(dismissVCWithCancelButton), for: .touchUpInside)
            
            okActionButton.configuration?.title = "Delete"
        }
        
        okActionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate(
        [
            actionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -padding),
            actionStackView.heightAnchor.constraint(equalToConstant: 30)
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
        guard let indexPath else {return}
        delegate?.didTappedOkButton(withIndexpath: indexPath)
      
    }
    
    
    @objc func dismissVCWithCancelButton() {
       dismiss(animated: true )
    }
}



