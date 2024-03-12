//
//  ContentView.swift
//  iPadPOC
//
//  Created by Save, Kautilya on 9/21/23.
//

import SwiftUI
import SwiftData



struct iPadHomeView: View {
    @State var text: String = ""
    @EnvironmentObject private var viewModel: TraktViewModel
    
    var body: some View {

        secondNavigationView
    }
}





// MARK: - Preview
#if os(visionOS)
#Preview(windowStyle: .automatic) {
    HomeNavigationView()
}
#endif

#if !os(visionOS)
#Preview {
    HomeNavigationView()
}
#endif

extension iPadHomeView {


    private var secondNavigationView: some View {
        
        
        TabView {
            
//            Text("Tab One")
//                .tabItem { Label("Featured", systemImage: "star") }
//                .onAppear { text = "Tab One's Items" }
            
            
            movieDetailView
                .tabItem { Label("Featured", systemImage: "list.bullet") }
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


