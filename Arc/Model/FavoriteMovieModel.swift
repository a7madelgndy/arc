//
//  FavoriteMovie.swift
//  Arc
//
//  Created by Ahmed El Gndy on 27/04/2025.
//

import UIKit

struct FavoriteMovieModel {
    let title:String
    let id : Int
    let adult : Bool
    let originalLanguage:String
    let originalCountry: String
    let overview:String
    let posterImage: UIImage
    let releaseDate:String
    let voteAverage:Float
    let backdropImage: UIImage?
    let runtime: Int16
    
    
    static func getfavoritMovie(movie: FavoriteMovieModel)-> FavoriteMovieModel{
        return FavoriteMovieModel(title: movie.title,
                                  id: movie.id,
                                  adult: movie.adult,
                                  originalLanguage: movie.originalLanguage,
                                  originalCountry: movie.originalCountry,
                                  overview: movie.overview,
                                  posterImage: movie.posterImage,
                                  releaseDate: movie.releaseDate,
                                  voteAverage:  movie.voteAverage,
                                  backdropImage: movie.backdropImage,
                                  runtime: movie.runtime)
    }
    
}
