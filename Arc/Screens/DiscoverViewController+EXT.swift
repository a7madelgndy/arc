//
//  DiscoverViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

extension DiscoverViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        default : populerMovie?.count ?? 0
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell else {
                fatalError("Unable deque cell...")
                
            }
            cell.cellData = populerMovie?[indexPath.row]
            return cell
        
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell else {
                fatalError("Unable deque cell...")
                
            }
            cell.cellData = populerMovie?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        default :
            let movie =  populerMovie?[indexPath.row]
            let movieVc = MovieDetilasVC()
            print(movie?.poster_path)
            movieVc.movieDetails = movie
            present(movieVc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: PopulerHeaderView.cellIdentifier, for: indexPath) as! PopulerHeaderView
        
            switch indexPath.section {
                case 0  :header.title = "Populer"
               case 1  : header.title = "Up Comming"
               default : header.title = "Top Rated"
            
        }
        return header
    }
}
