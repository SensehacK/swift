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

#Preview(windowStyle: .automatic) {
    var viewModel: TraktViewModel = TraktViewModel()
    if case let .success(traktMovie) = TraktMovies.from(localJSON: "trakt_recent_movies"),
       case let .success(tmdbMovie) = TMDBMovieAPI.from2(localJSON: "tmdb_movie") {
        
        let dummyImage = UIImage(named: "cloud.drizzle.fill")!
        let tMovie = traktMovie.first!
        
        let movieView = TraktConsumableView(id: 12, traktDetails: tMovie, tMDBDetails: tmdbMovie, posterImage: dummyImage, backgroundImage: dummyImage, trailerImage: "as23")
        
        MovieDetailView(movie: movieView)
//            .environmentObject(viewModel)
        
    } else {
        MovieDetailView(movie: nil)
//            .environmentObject(viewModel)
    }
    
    
//    guard case let .success(tmdbMovie) = TMDBMovieAPI.from(localJSON: "tmdb_movie") else {
//        MovieDetailView()
//        
//    }
    
    
//    switch TMDBMovieAPI.from(localJSON: "tmdb_movie") {
//    case .success(let movie):
//        print("Success")
//        MovieDetailView()
//
//    case .failure(let error):
//        print("Failed")
//        MovieDetailView()
//        let movieView = TraktConsumableView(id: movie.id, traktDetails: , tMDBDetails: <#T##TMDBMovieAPI#>, posterImage: <#T##UIImage#>, backgroundImage: <#T##UIImage#>, trailerImage: <#T##String#>)
//        MovieDetailView(movie: movie)
   
//    MovieDetailView(movie: )
}
