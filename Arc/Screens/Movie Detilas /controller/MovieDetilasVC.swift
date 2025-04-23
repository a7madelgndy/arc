//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit


class MovieDetilasVC: DataLoadingVC {
    
    //Movieposter
    var moviePosterView = MovieBoosterView()
    var movieHeaderView = MovieHeaderView()
    var categroiesView : movieCategoriesView?
    var playTailerView = TrailerPlayerView()
    
    var movieDetails: Movie?{
        didSet {
            guard let movieDetails else {return}
            moviePosterView.cellData = movieDetails.poster_path
            movieHeaderView.viewData = movieDetails.title
            categroiesView = movieCategoriesView(rating: movieDetails.vote_average, language: movieDetails.original_language, releadeData: movieDetails.release_date, isAdult: movieDetails.adult)
            movieHeaderView.delegage = self
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    
    }
    
    func configure() {
        view.addSubview(moviePosterView)
        view.addSubview(movieHeaderView)
        view.addSubview(playTailerView)
        
        guard let categroiesView else {return}
        view.addSubview(categroiesView)
        
        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterView.topAnchor.constraint(equalTo: view.topAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePosterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePosterView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        movieHeaderView.setConstrains(top: moviePosterView.bottomAnchor , leading:  view.leadingAnchor , trailing: view.trailingAnchor ,paddingTop: 10, height: 50)
   
        
        categroiesView.setConstrains(top:movieHeaderView.bottomAnchor , leading: view.leadingAnchor,trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20,paddingRight: 20 , height: 40)
        
        playTailerView.setConstrains(top:categroiesView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 , height: 40)
        playTailerView.delegate = self
  
        
    }
}

//movieposter

//movie name  save button share

//play Button

// dicription ........ViewMore

//caste collection View

extension MovieDetilasVC:FavoriteButtonDelegate {
    func didtapedFavoriteButton() {
        print("favorite Button Tapped")
    }
  
}

extension MovieDetilasVC:playTrailerDelegte {
    func didTappedPlayButton() {
        guard let movieId = movieDetails?.id else {return}
        
        let entpoint = "https://api.themoviedb.org/3/movie/\(movieId)/videos"
        
        guard let url = URL(string: entpoint) else {
            presentAler(
                title: "Invalid URL", message: "There is no Video For this movie", buttonTile: "ok")
            return
        }
        pressenSafrieVC(with: url)

    }
    
    
}

