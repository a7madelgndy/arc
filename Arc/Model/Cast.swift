//
//  Cast.swift
//  Arc
//
//  Created by Ahmed El Gndy on 23/04/2025.
//

import Foundation

struct castResponse: Codable{
   let  cast: [Actor]
}

struct Actor: Codable {
    let name:String
    let profile_path:String
}

