//
//  FavoriteMovie.swift
//  Arc
//
//  Created by Ahmed El Gndy on 27/04/2025.
//

import UIKit
import CoreData

struct FavoriteMovieModel {
    let posterImage: UIImage
    var title:String
    let release_date:String
    let vote_average:Float
    let original_language:String
    let adult : Bool
    let id : Int
    let overview:String
    
    static func convertNSManagedObjectToMovie(favoriteMovies :[NSManagedObject])-> [FavoriteMovieModel] {
         var movies : [FavoriteMovieModel] = []
         for movie in favoriteMovies{
             
             guard  let moviTitle = movie.value(forKey: "title") as? String else {
                 fatalError("coundn't find MovieTitle  in CoreData")
             }
        guard let movieId = movie.value(forKey: "id") as? Int else {return []}
                
        guard let  posterImage = movie.value(forKey: "posterImage") as? UIImage else {fatalError("coundn't find image  in CoreData")}
             
         guard let vote_average = movie.value(forKey: "voteAverage") as? Float else {
          fatalError("coundn't find MovieTitle  in CoreData")}
             
         guard let original_language = movie.value(forKey: "originalLanguage") as? String  else { fatalError("coundn't find MovieTitle  in CoreData")}
             
         guard let adult = movie.value(forKey: "adult") as? Bool else {fatalError("coundn't find MovieTitle  in CoreData")}
             
        guard let overview = movie.value(forKey: "overview") as? String else {fatalError("coundn't find MovieTitle  in CoreData")}
             
          guard let release_date = movie.value(forKey: "releaseData") as? String else {fatalError("coundn't find MovieTitle  in CoreData")}
             
             let convertedmovie = FavoriteMovieModel(posterImage: posterImage
                                                     ,title: moviTitle
                                                     ,release_date: release_date
                                                     ,vote_average: vote_average
                                                     ,original_language: original_language
                                                     ,adult: adult
                                                     ,id: movieId
                                                     ,overview:overview)

             
             movies.append(convertedmovie)
         }
         return movies
     }
}
//let convertedmovie = FavoriteMovieModel(posterImage: posterImage
//                                        ,title: moviTitle
//                                        ,release_date: release_date
//                                        ,vote_average: vote_average
//                                        ,original_language: original_language
//                                        ,adult: adult
//                                        ,id: movieId
//                                        ,overview: overview)

/*
 let convertedmovie = FavoriteMovieModel(posterImage: UIImage()
                                         ,title: moviTitle
                                         ,release_date: ""
                                         ,vote_average: 1.3
                                         ,original_language: ""
                                         ,adult: false
                                         ,id: movieId
                                         ,overview: "")
 */
