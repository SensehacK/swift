//
//  TMDBMovie.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation

// MARK: - TMDBMovieAPI

struct TMDBMovieAPI: Codable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID: String?
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case budget, genres, homepage, id
        case imdbID
        case originalLanguage
        case originalTitle
        case overview, popularity
        case posterPath
        case releaseDate
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage
        case voteCount
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
