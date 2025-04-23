//
//  Cast.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import Foundation

struct MovieCastResponse: Codable{
    let id : Int
   let  cast: [CastMember]
}

struct CastMember: Codable {
    let name: String
    let profile_path : String?
}

