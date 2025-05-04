//
//  File.swift
//  Arc
//
//  Created by Ahmed El Gndy on 19/04/2025.
//

import UIKit



//MARK: Network Manager
actor NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let decoder = JSONDecoder()
    
    func getMovies(category: Category, pageNumber: Int) async throws -> [Movie]{
        let request = APIComponet.makeRequest(withUrl: APIEndPoint.geturlWithCategory(with: category) , pageNumber: pageNumber)
        
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
            guard let youtubeUrl  = URL(string: "https://www.youtube.com/watch?v=\(youtubeKey)")  else {return nil}
            return youtubeUrl
        }catch {
            throw ErrorMassages.unableToDecodeVideoData
        }
    }
    func searchForAMovie(with text: String)async throws -> [Movie]?{
        let encodeQuery = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(encodeQuery)")!
        let request = APIComponet.makeRequest(withUrl: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        print(data)
        do {
            let moviesResponse = try decoder.decode(MovieResponse.self, from: data)
            print(moviesResponse.results)
            return moviesResponse.results
        }catch {
            
          print("error")
        }
       return []
    }
    
    func getMovieDetails(with id : Int) async throws -> MovieDetails {
        let request = APIComponet.makeRequest(withUrl: APIEndPoint.movieDetials(movieID: id))
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let movieDetails = try decoder.decode(MovieDetails.self, from: data)
            print(movieDetails)
            return movieDetails
        }catch {
            throw ErrorMassages.unableToDecodeVideoData
        }
    }
    
    func downloadImage(from urlPath: String , imageQuality: ImageQualities ) async -> UIImage? {
        let url = "https://image.tmdb.org/t/p/\(imageQuality.rawValue)\(urlPath)"
        guard let url = URL(string: url) else {return nil}
        do {
            
            let (data, _) = try await  URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else {return nil}
                        
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
        
    }
}


