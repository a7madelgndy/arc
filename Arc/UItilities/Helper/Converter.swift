//
//  Converter.swift
//  Arc
//
//  Created by Ahmed El Gndy on 01/05/2025.
//

import CoreData
import UIKit


struct Converter {
    static func convertNSManagedObjectToMovie(favoriteMovies :[NSManagedObject])-> [FavoriteMovieModel] {
        var movies : [FavoriteMovieModel] = []
        for movie in favoriteMovies{
            
            guard  let title = movie.value(forKey: "title") as? String else {fatalError("No found in CoreData")}
            guard let id = movie.value(forKey: "id") as? Int else {fatalError("No found in CoreData")}
            
            guard let  posterImage = movie.value(forKey: "posterImage") as? UIImage else {fatalError("No found in CoreData")}
            
            guard let voteAverage = movie.value(forKey: "voteAverage") as? Float else { fatalError("No found in CoreData")}
            
            guard let originalLanguage = movie.value(forKey: "originalLanguage") as? String  else { fatalError("No found in CoreData")}
            
            guard let adult = movie.value(forKey: "adult") as? Bool else {fatalError("No found in CoreData")}
            
            guard let overview = movie.value(forKey: "overview") as? String else {fatalError("No found in CoreData")}
            
            guard let releaseDate = movie.value(forKey: "releaseData") as? String else {fatalError("No found in CoreData")}
            
            
            guard let runtime = movie.value(forKey: "runtime") as? Int else {fatalError("No found in CoreData")}
            guard let backdropImage = movie.value(forKey: "backdropImage") as? UIImage else {fatalError("No found in CoreData")}
            guard let originalCountry = movie.value(forKey: "originalCountry") as? String else {fatalError("No found in CoreData")}
            
             let convertedMovie = FavoriteMovieModel(title: title,
                                                id: id,
                                                adult: adult,
                                                originalLanguage: originalLanguage,
                                                originalCountry: originalCountry,
                                                overview: overview,
                                                posterImage: posterImage,
                                                releaseDate: releaseDate,
                                                voteAverage: voteAverage,
                                                backdropImage: backdropImage,
                                                runtime: Int16(runtime))
            
            
            movies.append(convertedMovie)
        }
        return movies
    }
    
  
}

