//
//  AppLayouts.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import Foundation
import UIKit

class AppLayouts {
    static let shared = AppLayouts()
    
    func populerMoviesSction()-> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(BannerSize.width), heightDimension: .absolute(BannerSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)) , elementKind: "Header" , alignment: .top)
        section.boundarySupplementaryItems = [header]

        
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: "SectionBackground")
        section.decorationItems = [decorationItem]
        
        return section
    }
}

#Preview{
    TabBarController()
}
