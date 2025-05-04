//
//  UiHelper.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import Foundation

import UIKit

struct UIHelper {
    
    static func createFourColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout {
        let width  = UIScreen.main.bounds.width
        let padding: CGFloat = 0
        let minimumItemSpacing: CGFloat = 10
        
        let itemCountPerRow: CGFloat = 2.8
        let totalSpacing = (padding * 2) + (minimumItemSpacing * (itemCountPerRow - 1))
        let itemWidth = (width - totalSpacing) / itemCountPerRow
        
        let flowlayout                  = UICollectionViewFlowLayout()
        flowlayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize             = CGSize(width: itemWidth, height: itemWidth+40 )
        flowlayout.scrollDirection      = .horizontal
        return flowlayout
    }
    
    static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout {
        let width                        = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availbleWidth               = width - ((padding*2) + (minimumItemSpacing*2))
        let itemWidth                   = availbleWidth/3
        
        let flowlayout                  = UICollectionViewFlowLayout()
        flowlayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize             = CGSize(width: itemWidth, height: itemWidth+40 )
        
        return flowlayout
    }
    
    static func createEmptyStateView()-> UIContentUnavailableConfiguration {
        var config = UIContentUnavailableConfiguration.empty()
        config.image = .init(systemName: "heart.slash")
        config.imageProperties.tintColor = .systemRed
        
        config.text = "No Favorites Movies"
        config.secondaryText = "Go Add some Favorites Form Discover Screen"
        config.textProperties.color = .systemRed
        return config
    }
}
