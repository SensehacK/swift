//
//  MainView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SafariServices

struct MainView: View {
    
    
    @EnvironmentObject private var viewModel: TraktViewModel
    
    
//    @StateObject var viewModel: TraktViewModel = TraktViewModel()
    @State var viewDidLoad: Bool = false
    
    
    var body: some View {
        VStack {
            
            if let movieViewData = viewModel.moviesViewData {
                let movies = movieViewData.values.compactMap { $0 }
                MoviesGrid(userMovies: movies)
            }
            
            if let success = viewModel.traktTVApi {
                Text(success)
                if let movieViewData = viewModel.moviesViewData {
                    Text("Another If condition check!")
                    let movies = movieViewData.values.compactMap { $0 }
                    MoviesGrid(userMovies: movies)
                }

                
            } else {
                if let movies = viewModel.movies {
                    Text("See this data ???")
                    Text(movies.firstMovieName ?? "No Movie damn!")
                }
                Text("Hello Sensehack!")
                
                Button("Sign In Trakt TV") {
                    viewModel.showSignInUser()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        print(viewModel.displaySafari)
                        viewModel.displaySafari = false
                        print("Hello Dismissal")
                    }
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

#Preview(windowStyle: .automatic) {
    MainView()
}
