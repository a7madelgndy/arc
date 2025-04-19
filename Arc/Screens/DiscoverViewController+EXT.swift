//
//  DiscoverViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

extension DiscoverViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
