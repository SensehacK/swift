//
//  HomeNavigationView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/21/23.
//

import Foundation

import SwiftUI

struct HomeNavigationView: View {
    
    @EnvironmentObject private var viewModel: TraktViewModel
//    @ObservedObject var viewModel2: TraktViewModel
    @State private var videoVM = VideoViewModel()
    
    var body: some View {
        secondNavigationView
    }
}

// MARK: - Preview
#if os(visionOS)
#Preview(windowStyle: .automatic) {
    HomeNavigationView()
//    HomeNavigationView(viewModel2: TraktViewModel())
}
#endif

#if !os(visionOS)
#Preview {
    HomeNavigationView()
}
#endif



extension HomeNavigationView {

    private var secondNavigationView: some View {
//        movieGridView
//            .tabItem { Label("List", systemImage: "list.bullet") }
        
        TabView {
            
            Text("Tab One")
                .tabItem { Label("Featured", systemImage: "star") }
//                .onAppear { text = "Tab One's Items" }
            
            VideoView()
                .environment(videoVM)
                .tabItem { Label("Video player", systemImage: "4k.tv") }
            
            movieDetailView
                .tabItem { Label("List", systemImage: "list.bullet") }
//                .onAppear { text = "Items of Tab Two" }
            

            movieGridView
                .tabItem { Label("List", systemImage: "list.bullet") }
//                .onAppear { text = "Items of Tab Three" }
            
            
        }
    }
    
    
    
    private var movieDetailView: some View {
        
        Group {
            if case let .success(traktMovie) = TraktMovies.from(localJSON: "trakt_recent_movies"),
               case let .success(tmdbMovie) = TMDBMovieAPI.from2(localJSON: "tmdb_movie"),
               let oneMovie = traktMovie.first {
                let dummyImage = UIImage(named: "movie_background_test")!
                let dummyImage2 = UIImage(named: "movie_poster_test")!
                
                let movieView = TraktConsumableView(id: 12, traktDetails: oneMovie, tMDBDetails: tmdbMovie, posterImage: dummyImage2, backgroundImage: dummyImage, trailerImage: "as23")
                
                MovieDetailView(movie: movieView)
                
                
            }
        }
    }
    
    
    
    private var movieGridView: some View {
       
        Group {
//            MainView(viewModel: viewModel2)
            MainView()
                .environmentObject(viewModel)
        }
    }
}

