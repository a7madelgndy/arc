//
//  Cast.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import Foundation

struct MovieCastResponse: Codable{
    let  cast: [CastMember]
    let  backdrop_path: String
}

struct CastMember: Codable {
    let name: String
    let profile_path : String?
}

