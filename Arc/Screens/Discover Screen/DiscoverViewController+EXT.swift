//
//  DiscoverViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit


extension DiscoverViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        default :
            let movie =  movies[indexPath.row]
            let movieVc = MovieDetilasVC()

            movieVc.set(with: movie)
            present(movieVc, animated: true)
        }
    }
}


extension DiscoverViewController: UICollectionViewDataSource {
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        switch section {
        default : return movies.count
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
        let imagePath:String = movies[indexPath.row].poster_path
        switch indexPath.section {
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
                fatalError("Unable deque cell...")}
            
            cell.configuer(posterImagePath: imagePath)
            return cell
        }
        
    }
//            default:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
//                    fatalError("Unable deque cell...")
//                    
//                }
//                cell.cellData = movies[indexPath.row]
//                return cell
//            }
        
    
    

    
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
