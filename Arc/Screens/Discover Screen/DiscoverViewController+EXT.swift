//
//  DiscoverViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit


extension DiscoverViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieVc = MovieDetilasVC()
        var movie:Movie?
        
        switch indexPath.section {
        case 0  : movie =  populerMovies[indexPath.row]
        case 1 :  movie =  upcommingMovies[indexPath.row]
        default : movie =  topRatedMovies[indexPath.row]
        }
        
        guard let movie else {return}
        movieVc.set(with: movie)
        present(movieVc, animated: true)
    }
}


extension DiscoverViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0  : return populerMovies.count
        case 1 :  return upcommingMovies.count
        default :  return topRatedMovies.count
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Unable deque cell...")}
        
        var imagePath:String = ""

        switch indexPath.section {
        case 0 :
            imagePath = populerMovies[indexPath.row].poster_path
            cell.configuer(posterImagePath: imagePath)
            if indexPath.row == populerMovies.count {
                getMovies(page: 1)
            }
            
        case 1:
            imagePath = upcommingMovies[indexPath.row].poster_path
            cell.configuer(posterImagePath: imagePath)
            
        default :
            imagePath = topRatedMovies[indexPath.row].poster_path
            cell.configuer(posterImagePath: imagePath)
            
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: SeactionHeaderView.cellIdentifier, for: indexPath) as! SeactionHeaderView
        
        switch indexPath.section {
        case 0  : header.title = "Populer"
        case 1  : header.title = "Up Comming"
        default : header.title = "Top Rated"
            
        }
        return header
    }
}
