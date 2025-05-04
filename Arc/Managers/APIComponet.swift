//
//  APIComponet.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//

import Foundation

struct APIComponet {
   static func makeRequest(withUrl : URL ,pageNumber:Int=1) -> URLRequest {
       var components = URLComponents(url: withUrl, resolvingAgainstBaseURL: true)!
       let queryItems: [URLQueryItem] = [
           URLQueryItem(name: "language", value: "en-US"),
           URLQueryItem(name: "page", value: String(pageNumber)),
       ]
       
       components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
       
       var request = URLRequest(url: components.url!)
       request.httpMethod = "GET"
       request.timeoutInterval = 10
       request.allHTTPHeaderFields = [
           "accept": "application/json",
           "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYzg0M2IwMjI0ZTU5YzU2MWZjNDQ4ODMyZTM3OGY2NSIsIm5iZiI6MTcyNzk2ODUwMS4xNzEsInN1YiI6IjY2ZmViNGY1ZTQ4MDE0OTE0Njg0ZThmYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zBQxSGAcEWWvucxQGXOk8RH2AsV48K_HaIJcsOz9Y44"
       ]
       
       return request
   }
}
