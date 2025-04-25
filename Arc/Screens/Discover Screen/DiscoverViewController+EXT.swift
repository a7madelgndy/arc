//
//  DiscoverViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit
extension DiscoverViewController : UICollectionViewDelegate {


}


extension DiscoverViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        default : populerMovie.count
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
                fatalError("Unable deque cell...")
                
            }
            cell.cellData = populerMovie[indexPath.row]
            
            if (populerMovie.count) - 1 == indexPath.item {
                page += 1
                getMovies(page: page)
            }
            return cell
        
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
                fatalError("Unable deque cell...")
                
            }
            cell.cellData = populerMovie[indexPath.row]
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        default :
            let movie =  populerMovie[indexPath.row]
            let movieVc = MovieDetilasVC()

            movieVc.movieDetails = movie
            present(movieVc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: SeactionHeaderView.cellIdentifier, for: indexPath) as! SeactionHeaderView
        
            switch indexPath.section {
                case 0  :header.title = "Populer"
               case 1  : header.title = "Up Comming"
               default : header.title = "Top Rated"
            
        }
        return header
    }
}
