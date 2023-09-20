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
    }
    
    
    func showSignInUser() {
        displaySafari = true
        setupObservers()
//        presentLogIn()
        
        
    }
    
    func showLoginSafari() {
        print("Here in state change")
        presentLogIn()
    }
    
    func refreshUI() {
        self.traktTVApi = "Success Callback!"
    }
    
 
}

import SafariServices
private extension TraktViewModel {
    func presentLogIn() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }

//        let traktAuth = SFSafariViewController(url: oauthURL)
//        present(traktAuth, animated: true, completion: nil)
//        
        
        // 1
        let vc = SFSafariViewController(url: oauthURL)
        
        // 2
        UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
        
    }
    
    
    func setupObservers() {
        NotificationCenter.default.addObserver(forName: .TraktSignedIn, object: nil, queue: nil) { [weak self] _ in
            
            UIApplication.shared.firstKeyWindow?.rootViewController?.dismiss(animated: true)
//            self?.dismiss(animated: true, completion: nil) // Dismiss the SFSafariViewController
            self?.refreshUI()
        }
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
