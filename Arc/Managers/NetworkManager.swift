//
//  File.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit

//MARK: API End Point
enum APIEndPoint {
    static let endPoint = "https://api.themoviedb.org/3/"
    
    static let populerMovies = URL(string:endPoint + "movie/popular")!
    

    static func getCast(movieID:String) -> URL {
        return URL(string: endPoint + "\(movieID)/credits")!
    }
    
    static func movieVedios(movieID: Int)-> URL {
        let url = endPoint + "/movie/\(movieID)/videos"
        return URL(string:url)!
    }

}


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

//MARK: Network Manager
struct NetworkManager {
    private let cache = NSCache<NSString, UIImage>()
    static let shared = NetworkManager()
    
    private init() {}
    
    private let decoder = JSONDecoder()

    func getMovies(pageNumber: Int) async throws -> [Movie]{
        let request = APIComponet.makeRequest(withUrl: APIEndPoint.populerMovies , pageNumber: pageNumber)
  
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response =  response as? HTTPURLResponse , response.statusCode == 200 else {
            throw ErrorMassages.invalidResponse
        }

        do {
            let movieResponse = try decoder.decode(MovieResponse.self, from: data)
            return movieResponse.results
        } catch {
            throw ErrorMassages.invalidDate
        }
    }
    
    
    func getMovieTrailerURL(movieID : Int) async throws -> URL?{
        let request = APIComponet.makeRequest(withUrl: APIEndPoint.movieVedios(movieID: movieID))
        
        let (data, _) = try await URLSession.shared.data(for: request)
    
        do {
            let vediosRespons = try decoder.decode(videosResponse.self, from: data)
            let youtubeKey = vediosRespons.results[0].key
            print(vediosRespons.results[0].key)
            guard let youtubeUrl  = URL(string: "https://www.youtube.com/watch?v=\(youtubeKey)")  else {return nil}
            return youtubeUrl
        }catch {
            throw ErrorMassages.unableToDecodeVideoData
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
        let enpoint = APIEndPoint.getCast(movieID: movieId)
        let request =  APIComponet.makeRequest(withUrl: enpoint , pageNumber: 1)
     
        let (data, _) = try await URLSession.shared.data(for: request)

        do {
            let castResponse = try decoder.decode(MovieCastResponse.self, from: data)
    
            return castResponse.cast
        }catch{
            
            return []
        }
        
    }}
