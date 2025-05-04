//
//  MovieDetails .swift
//  Arc
//
//  Created by Ahmed El Gndy on 01/05/2025.
//

import Foundation

struct MovieDetails: Codable,Hashable {

    
    let adult: Bool
    let backdrop_path: String?
    let genres: [Genre]
    let id: Int
    let origin_country: [String]
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let revenue: Int
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int

}

struct Genre: Codable,Hashable  {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable,Hashable  {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable,Hashable  {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable,Hashable  {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

