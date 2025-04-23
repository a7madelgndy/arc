//
//  DataloadingVcViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit
import SafariServices
class DataLoadingVC: UIViewController {
    
    private var containerView : UIView!

    func showLoadingView() {
        containerView  = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.3) {self.containerView.alpha = 0.8  }
        
        let activiyIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activiyIndicator)
        activiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activiyIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activiyIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activiyIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func pressenSafrieVC(with url : URL){
        let safariVc = SFSafariViewController(url: url)
        safariVc.preferredControlTintColor = .systemPurple
        present(safariVc, animated: true)
    }
}



