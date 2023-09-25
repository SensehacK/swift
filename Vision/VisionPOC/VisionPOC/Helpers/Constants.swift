//
//  Constants.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import Foundation


struct URLConstants {
    static let traktMovieTestURL = "https://api.trakt.tv/users/sensehack/history/movies/"
    static let tMovieDBTestURL = "https://api.themoviedb.org/3/movie/100402?api_key=\(APIKeys.tmdb)&language=en-US"
    static let movieBaseURL = "https://api.themoviedb.org/3/movie/"
    static let tmdbAPIKeyParam = "?api_key=\(APIKeys.tmdb)&language=en-US"
    
    
    static let movieImageBaseURL = "https://image.tmdb.org/t/p/"
    
    
}


struct APIKeys {
    static let trakt = "YOUR_API_KEY"
    static let tmdb = "YOUR_API_KEY"
}



struct TraktAPI {
    static let clientId = "YOUR_API_CLIENT_ID"
    static let clientSecret = "YOUR_API_SECRET_KEY"
    static let redirectURI = "visionP:"
}


//https://image.tmdb.org/t/p/w1280/fK40VGYIm7hmKrLJ26fgPQU0qRG.jpg
// https://image.tmdb.org/t/p/w500/neZ0ykEsPqxamsX6o5QNUFILQrz.jpg
enum Resolution {
    
    enum Poster: String {
        case w500
        
    }
    
    
    enum Background: String {
        case w1280
    }
    
    
}
