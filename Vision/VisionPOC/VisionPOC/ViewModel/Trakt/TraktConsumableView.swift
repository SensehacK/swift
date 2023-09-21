//
//  TraktConsumableView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import UIKit


struct TraktConsumableView: Identifiable {
    let id: Int
    private let movieDetails: TraktMovie
    
    let posterImage: UIImage
    let backgroundImage: UIImage
    let trailerImage: String

    
    
    init(id: Int, movieDetails: TraktMovie, posterImage: UIImage, backgroundImage: UIImage, trailerImage: String) {
        self.id = id
        self.movieDetails = movieDetails
        self.posterImage = posterImage
        self.backgroundImage = backgroundImage
        self.trailerImage = trailerImage
    }
    
    
    var title: String {
        movieDetails.movie.title
    }
    
    
    
    
    
    
    
}








struct TraktViewData {
    private let traktMovies: TraktMovies
    
    init(movies: TraktMovies, id: Int) {
        self.traktMovies = movies
    }

    var firstMovieName: String? {
        traktMovies.first?.movie.title
    }
    
    
    func getMovie(id: Int) -> TraktMovie? {
        traktMovies.filter { $0.id == id }.first
    }
    
    var allMovies: TraktMovies {
        traktMovies
    }
}
