//
//  TraktMovies.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import Foundation
// MARK: - TraktMovie
struct TraktMovieAPI: Codable {
    let id: Int
    let watchedAt: String
    let action: Action
    let type: TypeEnum
    let movie: Movie

    enum CodingKeys: String, CodingKey {
        case id
        case watchedAt = "watched_at"
        case action, type, movie
    }
}

enum Action: String, Codable {
    case checkin = "checkin"
    case watch = "watch"
    case scrobble = "scrobble"
}

// MARK: - Movie
struct Movie: Codable {
    let title: String
    let year: Int
    let ids: IDS
}

// MARK: - IDS
struct IDS: Codable {
    let trakt: Int
    let slug, imdb: String
    let tmdb: Int
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}

typealias TraktMovies = [TraktMovieAPI]
