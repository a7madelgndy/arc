//
//  MovieDetilasVC.swift
//  Arc
//
//  Created by Ahmed El Gndy on 22/04/2025.
//

import UIKit

class MovieDetilasVC: UIViewController {
    
    //Movieposter
    var moviePosterView = MovieBoosterView()
    
    var movieHeaderView = MovieHeaderView()
    //MovieTile
    var movieDetails: Movie?{
        didSet {
            guard let movieDetails else {return}
            moviePosterView.cellData = movieDetails.poster_path
            movieHeaderView.viewData = movieDetails.title
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
        
        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterView.topAnchor.constraint(equalTo: view.topAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePosterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePosterView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        movieHeaderView.setConstrains(top: moviePosterView.bottomAnchor , leading:  view.leadingAnchor , trailing: view.trailingAnchor ,paddingTop: 10, height: 50)
        movieHeaderView.backgroundColor = .systemGray5
    }
}

//movieposter

//movie name  save button share

//play Button

// dicription ........ViewMore

//caste collection View
