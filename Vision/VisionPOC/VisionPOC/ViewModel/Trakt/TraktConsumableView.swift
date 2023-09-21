//
//  TraktConsumableView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import UIKit


struct TraktConsumableView: Identifiable {
    let id: Int
    private let traktDetails: TraktMovieAPI
    private let tMDBDetails: TMDBMovieAPI
    let posterImage: UIImage
    let backgroundImage: UIImage
    let trailerImage: String

    
    
    init(id: Int, traktDetails: TraktMovieAPI, tMDBDetails: TMDBMovieAPI, posterImage: UIImage, backgroundImage: UIImage, trailerImage: String) {
        self.id = id
        self.traktDetails = traktDetails
        self.tMDBDetails = tMDBDetails
        self.posterImage = posterImage
        self.backgroundImage = backgroundImage
        self.trailerImage = trailerImage
    }
    
    
    var title: String {
        traktDetails.movie.title
    }
    
    
    var detail: TMDBMovieAPI { tMDBDetails }
    
    var overview: String { tMDBDetails.overview }
    
    
    
    
    
    
    
}








struct TraktViewData {
    private let traktMovies: TraktMovies
    
    init(movies: TraktMovies, id: Int) {
        self.traktMovies = movies
    }

    var firstMovieName: String? {
        traktMovies.first?.movie.title
    }
    
    
    func getMovie(id: Int) -> TraktMovieAPI? {
        traktMovies.filter { $0.id == id }.first
    }
    
    var allMovies: TraktMovies {
        traktMovies
    }
}
