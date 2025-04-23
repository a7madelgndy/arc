//
//  castView.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import UIKit

class castView: UIView {

    private var collectionView:UICollectionView!
    
    func configureCollectoinView() {
        collectionView.delegate = self
        addSubViews(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CastCell.self , forCellWithReuseIdentifier: CastCell.reuseIdentifier)
    }

}
extension castView: UICollectionViewDelegate {
    
}
