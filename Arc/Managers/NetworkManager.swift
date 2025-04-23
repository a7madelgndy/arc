//
//  File.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit
enum APIEndPoint {
    static let pupuler = "https://api.themoviedb.org/3/movie/now_playing"
    
    static func getCast(movieId : String) -> String {
        return "https://api.themoviedb.org/3/movie/\(movieId)/credits"
    }
}

struct APIComponet {

   static func makeRequest(withUrl : URL) -> URLRequest {
        var components = URLComponents(url: withUrl, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
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

struct NetworkManager {
    let cache = NSCache<NSString, UIImage>()
    static let shared = NetworkManager()
    private init() {}
    
    
    func getMovies() async throws -> [Movie]{
        
        guard let url = URL(string:APIEndPoint.pupuler) else {
            throw ErrorMassages.defulatErrorMassage
        }
        
        var request = APIComponet.makeRequest(withUrl: url)
  
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response =  response as? HTTPURLResponse , response.statusCode == 200 else {
            throw ErrorMassages.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            let movieResponse = try decoder.decode(MovieResponse.self, from: data)
            return movieResponse.results
        } catch {
            throw ErrorMassages.invalidDate
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cachekey = NSString(string: urlString)
        if let image = self.cache.object(forKey: cachekey){return image}
        
        guard let url = URL(string: urlString) else {return nil}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {return nil}
            
            self.cache.setObject(image, forKey: cachekey)
            
            return image
        }catch {
            return nil
        }
    }
    
    func getMovieCast(movieId: String)async throws -> [CastMember]?{
        let enpoint = APIEndPoint.getCast(movieId: movieId)
        guard let url = URL(string: enpoint) else {return nil}
        
        var request =  APIComponet.makeRequest(withUrl: url)
     
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        do {
            let castResponse = try decoder.decode(MovieCastResponse.self, from: data)
    
            return castResponse.cast
        }catch{
            
            return []
        }
        
    }}
