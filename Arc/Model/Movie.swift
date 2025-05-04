//
//  Movie.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import Foundation


struct MovieResponse: Codable, Hashable{
   let  results:[Movie]
}

struct Movie: Codable, Hashable {
    
    let poster_path:String?
    let id : Int
    let title: String

}

