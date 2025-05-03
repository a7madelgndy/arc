//
//  DataLoadingImageView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 03/05/2025.
//

import UIKit
import Dispatch

class DataLoadingImageView: UIImageView {
    
    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }
    
    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
    func showSkeleton() {
        let backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
        let highlightColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        
        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size =  bounds.size
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame =  bounds
        gradientLayer.name = skeletonGradientName
        
        layer.mask = skeletonLayer
        layer.addSublayer(gradientLayer)
        clipsToBounds = true
        let widht = bounds.width
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.fromValue = -widht
        animation.toValue = widht
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
        
    }
    
    // 6
    func hideSkeleton() {
        layer.sublayers?.removeAll {
            $0.name == skeletonLayerName || $0.name == skeletonGradientName
        }
    }
    
    
    
}
