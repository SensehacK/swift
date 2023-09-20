//
//  TraktViewModel.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import Foundation

@MainActor
class TraktViewModel: ObservableObject {
    
    
    @Published var movies: TraktViewData?
    
    
    let serviceFetcher: TraktService
    
    init(movies: TraktViewData? = nil,
         serviceFetcher: TraktService = TraktDataFetcher.shared) {
        self.movies = movies
        self.serviceFetcher = serviceFetcher
        
    }
    
    func fetchData() async {
        print("Fetching movies??")
        movies = await serviceFetcher.fetchTrakts()
    }
    
}



struct TraktViewData {
//    let id: Int
    private let traktMovies: TraktMovies
    
    init(movies: TraktMovies, id: Int) {
        self.traktMovies = movies
//        self.id = id
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
