//
//  DataloadingVcViewController.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit
import SafariServices

//To activity Indector / skeleton view when the data is loading
class DataLoadingVC: UIViewController {
    
    private var containerView : UIView!

    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }

    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
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
        safariVc.preferredControlTintColor = Colors.main
        present(safariVc, animated: true)
    }
    
    

    private func skeletonViews(in view: UIView) -> [UIView] {
        var results = [UIView]()
        for subview in view.subviews as [UIView] {
            switch subview {
            case _ where subview.isKind(of: UILabel.self):
                results += [subview]
            case _ where subview.isKind(of: UIImageView.self):
                results += [subview]
            case _ where subview.isKind(of: UIButton.self):
                results += [subview]
            default: results += skeletonViews(in: subview)
            }

        }
        return results
    }

    // 5
    func showSkeleton() {
        let skeletons = skeletonViews(in: view)
        let backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
        let highlightColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor

       

        skeletons.forEach { skeletonView in
            let skeletonLayer = CALayer()
            skeletonLayer.backgroundColor = backgroundColor
            skeletonLayer.name = skeletonLayerName
            skeletonLayer.anchorPoint = .zero
            skeletonLayer.frame.size = skeletonView.bounds.size
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.frame = skeletonView.bounds
            gradientLayer.name = skeletonGradientName

            skeletonView.layer.mask = skeletonLayer
            skeletonView.layer.addSublayer(gradientLayer)
            skeletonView.clipsToBounds = true
            let widht = skeletonView.bounds.width

            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 3
            animation.fromValue = -widht
            animation.toValue = widht
            animation.repeatCount = .infinity
            animation.autoreverses = false
            animation.fillMode = CAMediaTimingFillMode.forwards

            gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
        }
    }

    // 6
    func hideSkeleton() {
        skeletonViews(in: view).forEach {
            $0.layer.sublayers?.removeAll {
                $0.name == skeletonLayerName || $0.name == skeletonGradientName
            }
        }
    }
}



