//
//  imageQuality.swift
//  Arc
//
//  Created by Ahmed El Gndy on 01/05/2025.
//

import Foundation
// The movie database images Sizing
enum ImageQualities{
    
    enum poster:String {
        case w92 = "w92"
        case w154 = "w154"
        case w342 = "w342"
        case w500 = "w500"
        case original = "original"
 
    }
    enum backdrop: String {
        case w300 = "w300"
        case w780 = "w780"
        case w1280 = "w1280"
        case original = "original"
    }
}
