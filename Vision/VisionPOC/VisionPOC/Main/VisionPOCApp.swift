//
//  VisionPOCApp.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI

@main
struct VisionPOCApp: App {
    
    // App Delegate
    @UIApplicationDelegateAdaptor var delegate: VSPAppDelegate
    
    @StateObject var viewModel: TraktViewModel = TraktViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            
            // Movie Detail View
             /*
            if case let .success(traktMovie) = TraktMovies.from(localJSON: "trakt_recent_movies"),
               case let .success(tmdbMovie) = TMDBMovieAPI.from2(localJSON: "tmdb_movie"),
               let oneMovie = traktMovie.first {
                let dummyImage = UIImage(named: "movie_background_test")!
                let dummyImage2 = UIImage(named: "movie_poster_test")!
                Text("Hello Here!")
                let movieView = TraktConsumableView(id: 12, traktDetails: oneMovie, tMDBDetails: tmdbMovie, posterImage: dummyImage2, backgroundImage: dummyImage, trailerImage: "as23")
                
                MovieDetailView(movie: movieView)

            } else {
                MovieDetailView(movie: nil)
            }
            // */
            
            // Testing Navigation Views right now
            HomeNavigationView()
                .environmentObject(viewModel)
            
            
            // Main Channel
             /*
            MainView()
                .environmentObject(viewModel)
                .onOpenURL { (url) in
                    // Handle url here
                    print("Hello Vision POC SwiftUI - Did I get a callback here!")
                    // Parse the URL callback from Trakt API Oauth
                    TokenCapture.parseURLSchemeToExtractToken(url: url)
                    //                    viewModel.displaySafari = false
                }
             */
        }
    }
}
