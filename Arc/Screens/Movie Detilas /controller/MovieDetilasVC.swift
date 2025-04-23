//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit


class MovieDetilasVC: DataLoadingVC {
    
    //Movieposter
    var posterView = MovieBoosterView()
    var headerView = MovieHeaderView()
    var categroiesView : movieCategoriesView?
    var playTailerView = TrailerPlayerView()
    
    var movieOverview = BodyLabel()
    var movieDetails: Movie?{
        didSet {
            guard let movieDetails else {return}
            posterView.cellData = movieDetails.poster_path
            headerView.viewData = movieDetails.title
            categroiesView = movieCategoriesView(rating: movieDetails.vote_average, language: movieDetails.original_language, releadeData: movieDetails.release_date, isAdult: movieDetails.adult)
            headerView.delegage = self
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    
    }
    
    func configure() {
        view.addSubview(posterView)
        view.addSubview(headerView)
        view.addSubview(playTailerView)
        view.addSubview(movieOverview)
        
        guard let categroiesView else {return}
        view.addSubview(categroiesView)
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: view.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        headerView.setConstrains(top: posterView.bottomAnchor , leading:  view.leadingAnchor , trailing: view.trailingAnchor ,paddingTop: 10, height: 50)
   
        
        categroiesView.setConstrains(top:headerView.bottomAnchor , leading: view.leadingAnchor,trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20,paddingRight: 20 , height: 40)
        
        playTailerView.setConstrains(top:categroiesView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop: 10 , paddingLeft: 20 , paddingRight: 20 , height: 40)
        playTailerView.delegate = self
        
        movieOverview.setConstrains(top: playTailerView.bottomAnchor , leading: view.leadingAnchor , trailing: view.trailingAnchor , paddingTop:  10 , paddingLeft:  20 , paddingRight: 20 , height: 100)
        movieOverview.text = movieDetails?.overview
  
        
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

