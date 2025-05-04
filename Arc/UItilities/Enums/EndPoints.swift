//
//  EndPoints.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import Foundation

//MARK: API End Point
enum APIEndPoint {
    static let endPoint = "https://api.themoviedb.org/3/"
    
    static func geturlWithCategory(with category: Category)->URL {
        switch category {
            
        case .populer: return URL(string:endPoint + "movie/popular")!
        case .upcomming: return URL(string:endPoint + "movie/upcoming")!
        case .TopRated: return URL(string:endPoint + "movie/top_rated")!
        }
    }
    
    static func getCast(movieID:String) -> URL {
        return URL(string: endPoint + "movie/\(movieID)/credits")!
    }
    
    static func movieVedios(movieID: Int)-> URL {
        let url = endPoint + "movie/\(movieID)/videos"
        return URL(string:url)!
    }
    
    static func movieDetials(movieID: Int)-> URL {
        let url = endPoint + "movie/\(movieID)"
        return URL(string: url)!
    }

}

