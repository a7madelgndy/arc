//
//  Movie.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import Foundation
import CoreData
struct MovieResponse: Codable{
   let  results:[Movie]
}

struct Movie: Codable {
    let poster_path:String
    var title:String
    let release_date:String
    let vote_average:Float
    let original_language:String
    let adult : Bool
    let id : Int
    let overview:String
    
   static func convertNSManagedObjectToMovie(favoriteMovies :[NSManagedObject])-> [Movie] {
        var movies : [Movie] = []
        for movie in favoriteMovies{
            let title = movie.value(forKey: "title") as? String
            let id = movie.value(forKey: "id") as? Int
            
            let convertedmovie = Movie(poster_path: " ", title:  title ?? "no", release_date: "", vote_average: 84.4, original_language: "", adult: false, id: id ?? 0, overview: "")
            movies.append(convertedmovie)
        }
        return movies 
    }
}

var mockDataMovie = Movie(poster_path: "", title: "", release_date: "", vote_average: 34.4, original_language: "", adult: false, id: 37, overview: "")
