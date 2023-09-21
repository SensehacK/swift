//
//  MovieDetailView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/21/23.
//

import SwiftSense
import SwiftUI


struct MovieDetailView: View {
    
//    let movie: TMDBMovieAPI?
//    @EnvironmentObject private var viewModel: TraktViewModel
    let movie: TraktConsumableView?
    var body: some View {
        VStack {
            
            Text("Your Movie")
            ScrollView {
                if let movie {
//                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8, content: {
                        Text(movie.title)
                        Text(movie.overview)
                        Text("Hello")
                        Image(uiImage: movie.posterImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                        
                        Image(uiImage: movie.backgroundImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 400, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)

                        
//                    })
                } else {
                    Text("No Init!")
                }
            }
            
            
            
        }
        .navigationTitle("Content")
        .padding()
    }
}

// MARK: - Preview
//var viewModel: TraktViewModel = TraktViewModel()

var movieView: TraktConsumableView? {
    if case let .success(traktMovie) = TraktMovies.from(localJSON: "trakt_recent_movies"),
       case let .success(tmdbMovie) = TMDBMovieAPI.from2(localJSON: "tmdb_movie") {
        
        let dummyImage = UIImage(named: "cloud.drizzle.fill")!
        let tMovie = traktMovie.first!
        
        let movieView = TraktConsumableView(id: 12, traktDetails: tMovie, tMDBDetails: tmdbMovie, posterImage: dummyImage, backgroundImage: dummyImage, trailerImage: "as23")
        
        return movieView
    }
    return nil
}
    
    


#if os(xrOS)
#Preview(windowStyle: .automatic) {
    // Working Code
    if case let .success(traktMovie) = TraktMovies.from(localJSON: "trakt_recent_movies"),
       case let .success(tmdbMovie) = TMDBMovieAPI.from2(localJSON: "tmdb_movie") {
        
        let dummyImage = UIImage(named: "cloud.drizzle.fill")!
        let tMovie = traktMovie.first!
        
        let movieView = TraktConsumableView(id: 12, traktDetails: tMovie, tMDBDetails: tmdbMovie, posterImage: dummyImage, backgroundImage: dummyImage, trailerImage: "as23")
        
        MovieDetailView(movie: movieView)
//            .environmentObject(Globals.traktViewModel)
        
    } else {
        MovieDetailView(movie: nil)
//            .environmentObject(Globals.traktViewModel)
//            .environmentObject(viewModel)
    }
    
    // Working Code End
    
    // New code
    

}

#endif

#if !os(xrOS)
#Preview {
    if let movieView {
        MovieDetailView(movie: movieView)
            .environmentObject(Globals.traktViewModel)
    } else {
        MovieDetailView(movie: nil)
    }
}
#endif
