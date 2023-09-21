//
//  TraktViewModel.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import Foundation
import UIKit

@MainActor
class TraktViewModel: ObservableObject {
    
    
    @Published var movies: TraktViewData?
    @Published var moviesViewData: [Int: TraktConsumableView]?
    
    @Published var traktTVApi: String?
    @Published var displaySafari: Bool = false
    
    
    let serviceFetcher: TraktService
    
    init(movies: TraktViewData? = nil,
         serviceFetcher: TraktService = TraktDataFetcher.shared) {
        self.movies = movies
        self.serviceFetcher = serviceFetcher
    }
    
    func fetchData() async {
        print("Fetching movies??")
        movies = await serviceFetcher.fetchTrakts()
        guard let allMovies = movies?.allMovies else { return }
        let randomID = allMovies.randomElement()?.movie.ids.tmdb ?? 149
//        let movie = await serviceFetcher.fetchSingleMovieDetails(id: randomID)
//        print("HEELLASOLFOAJGOAFGKMAWFMFA")
//        print(movie?.originalTitle)
//        print(movie?.posterPath)
        moviesViewData = try? await serviceFetcher.fetchAllRecentMoviesDetailsWithImagesAsync(movies: allMovies)
    }
    
    
    func showSignInUser() {
        displaySafari = true
        setupObservers()
        // presentLogIn()

    }
    
    func showLoginSafari() {
        print("Here in state change")
        presentLogIn()
    }
    
    func refreshUI() {
        displaySafari = false
        self.traktTVApi = "Success Callback!"
    }
    
 
}

import SafariServices
private extension TraktViewModel {
    func presentLogIn() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }

        let vc = SFSafariViewController(url: oauthURL)
        UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
        
    }
    
    
    func setupObservers() {
        NotificationCenter.default.addObserver(forName: .TraktSignedIn, object: nil, queue: nil) { [weak self] _ in
            UIApplication.shared.firstKeyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            self?.refreshUI()
        }
    }
}




