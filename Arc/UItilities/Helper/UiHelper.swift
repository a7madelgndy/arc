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
        let width  = view.bounds.width
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        
        let itemCountPerRow: CGFloat = 4
        let totalSpacing = (padding * 2) + (minimumItemSpacing * (itemCountPerRow - 1))
        let itemWidth = (view.bounds.width - totalSpacing) / itemCountPerRow
        
        let flowlayout                  = UICollectionViewFlowLayout()
        flowlayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize             = CGSize(width: 120, height: 100 )
        flowlayout.scrollDirection      = .horizontal
    
        return flowlayout
    }
}
