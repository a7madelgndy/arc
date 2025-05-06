//
//  DiscoverViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

//MARK: - extension Collection View Delegate

extension DiscoverViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieVc = MovieDetailsVC()
        var movieId:Int?
        
        switch indexPath.section {
        case 0  : movieId =  popularMovies[indexPath.row].id
        case 1 :  movieId =  upcommingMovies[indexPath.row].id
        default : movieId =  topRatedMovies[indexPath.row].id
        }
        
        guard let movieId else {return}
        
        showLoadingView()
        Task{
            do{
                movieVc.movieDetails = try  await NetworkManager.shared.getMovieDetails(with: movieId)
                let movieVc = movieVc
                present(movieVc, animated: true)
            }catch {
                presentDefaultError()
            }
          dismissLoadingView()
        }
    }
}

//MARK: - extension Collection Data Source

extension DiscoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //4 to manage the Skeleton View
        switch section {
        case 0  : return popularMovies.isEmpty ? 4 : popularMovies.count
        case 1 :  return upcommingMovies.isEmpty ? 4 : upcommingMovies.count
        default :  return topRatedMovies.isEmpty ? 4 :  topRatedMovies.count
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {3}
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Unable deque cell...")}
        
        var imagePath:String = ""

        switch indexPath.section {
        case 0 :
            if popularMovies.isEmpty  {
                return cell
            }else {
                imagePath = popularMovies[indexPath.row].poster_path!
                cell.configuer(posterImagePath: imagePath)
            }
       
            
        case 1:
            if upcommingMovies.isEmpty  {
                return cell
            }else {
                imagePath = upcommingMovies[indexPath.row].poster_path ?? " " 
                cell.configuer(posterImagePath: imagePath)
            }
           
            
        default :
            if  topRatedMovies.isEmpty  {
                return cell
            }else  {
                imagePath = topRatedMovies[indexPath.row].poster_path ?? " "
                cell.configuer(posterImagePath: imagePath)
            }
           
            
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
