//
//  Movie.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import Foundation

struct MovieResponse: Codable{
   let  results:[Movie]
}

struct Movie: Codable {
    let poster_path:String
    let title:String
    let release_date:String
    let vote_average:Float
    let original_language:String
    let adult : Bool
    let id : Int
    let overview:String
}
