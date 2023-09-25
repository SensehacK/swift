//
//  MainView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI

#if os(xrOS)
import RealityKit
import RealityKitContent
#endif
import SafariServices

struct MainView: View {
    
    
    @EnvironmentObject private var viewModel: TraktViewModel
    
    
//    @StateObject var viewModel: TraktViewModel = TraktViewModel()
    @State var viewDidLoad: Bool = false
    
    
    var body: some View {
        VStack {
            
            // Good catch of this UI duplicate bug since I totally forgot about Oauth flow while testing hardcoding values.
//            if let movieViewData = viewModel.moviesViewData {
//                let movies = movieViewData.values.compactMap { $0 }
//                MoviesGrid(userMovies: movies)
//            }
            
            // Oauth Sign In Conditional UI
            if let success = viewModel.traktTVApi {
                Text(success)
                if let movieViewData = viewModel.moviesViewData {
                    Text("Another If condition check!")
                    let movies = movieViewData.values.compactMap { $0 }
                    MoviesGrid(userMovies: movies)
                }

                
            }
            // Non Oauth Hardcoded data.
            else {
                
                if let movieViewData = viewModel.moviesViewData {
                    let movies = movieViewData.values.compactMap { $0 }
                    MoviesGrid(userMovies: movies)
                }
                
//                if let movies = viewModel.movies {
//                    Text("See this data ???")
//                    Text(movies.firstMovieName ?? "No Movie damn!")
//                }
                Text("Hello Sensehack!")
                
                Button("Sign In Trakt TV") {
                    viewModel.showSignInUser()
                }
            }
            
        }
        .navigationTitle("Content")
        .task {
            print("AHGAG23")
            if !viewDidLoad {
                print("HASE")
                await viewModel.fetchData()
                viewDidLoad = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.displaySafari) {
//            viewModel.showLoginSafari()
            SafariWebView(url: TraktManager.sharedManager.oauthURL!)
                .ignoresSafeArea()
        }
        .padding()
    }
}

#if os(xrOS)
#Preview(windowStyle: .automatic) {
    MainView()
}
#endif

#if !os(xrOS)
#Preview {
    MainView()
}
#endif
