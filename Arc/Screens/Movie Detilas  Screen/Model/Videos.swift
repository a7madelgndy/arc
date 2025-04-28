//
//  Videos.swift
//  Arc
//
//  Created by Ahmed El Gndy on 28/04/2025.
//

import Foundation

struct videosResponse: Codable {
    let results :[Video]
}

//vedio key is the key to open youtube Vedio
//ex https://www.youtube.com/watch?v=\(vedioKey)
struct Video: Codable {
    let key : String
}
