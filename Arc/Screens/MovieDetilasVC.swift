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
    var movieDetails: Movie?{
        didSet {
            guard let movieDetails else {return}
            moviePosterView.cellData = movieDetails.poster_path
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    
    }
    
    func configure() {
        view.addSubview(moviePosterView)
        moviePosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterView.topAnchor.constraint(equalTo: view.topAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePosterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePosterView.heightAnchor.constraint(equalToConstant: 300)
        ])
        moviePosterView.backgroundColor = .gray
    }
}

//movieposter

//movie name  save button share

//play Button

// dicription ........ViewMore

//caste collection View
