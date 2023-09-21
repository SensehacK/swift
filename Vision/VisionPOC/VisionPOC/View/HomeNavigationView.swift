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
    @State var text: String = ""
    
    var body: some View {
        //        firstNavigationSplitView
        secondNavigationView
    }
}

#Preview(windowStyle: .automatic) {
    HomeNavigationView()
}



extension HomeNavigationView {
    private var firstNavigationSplitView: some View {
        Group {
            NavigationSplitView {
                TabView {
                    Text("Tab One")
                        .tabItem { Label("Featured", systemImage: "star") }
                        .onAppear { text = "Tab One's Items" }
                    Text("Tab Two")
                        .tabItem { Label("List", systemImage: "list.bullet") }
                        .onAppear { text = "Items of Tab Two" }
                }.tabViewStyle(.page)
                List {
                    Text(text)
                        .onChange(of: text) { _, newValue in
                            text = newValue
                        }
                }
            } detail: {
                // some code
            }
            .navigationTitle("Content")
            .padding()
        }
    }
    
    
    
    
    private var secondNavigationView: some View {
        
        
        TabView {
            
            Text("Tab One")
                .tabItem { Label("Featured", systemImage: "star") }
                .onAppear { text = "Tab One's Items" }
            
            
            movieDetailView
                .tabItem { Label("List", systemImage: "list.bullet") }
                .onAppear { text = "Items of Tab Two" }
            

            movieGridView
                .tabItem { Label("List", systemImage: "list.bullet") }
                .onAppear { text = "Items of Tab Three" }
            
            
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
            MainView()
                .environmentObject(viewModel)
        }
    }
}

