//
//  TraktViewModel.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import Foundation
import UIKit
import Combine

@MainActor
class TraktViewModel: ObservableObject {
    
    
    var movies: TraktViewData?
    @Published var moviesViewData: [Int: TraktConsumableView]?
    
    @Published var traktTVApi: String?
    @Published var displaySafari: Bool = false
    
    
    let serviceFetcher: TraktService
    var cancellables = Set<AnyCancellable>()
    var traktCallback: AnyCancellable?
    
    init(movies: TraktViewData? = nil,
         serviceFetcher: TraktService = TraktDataFetcher.shared) {
        self.movies = movies
        self.serviceFetcher = serviceFetcher
        print("$$$$ Init: VM")
        listenerToChangesDebug()
        setupObservers()
    }
    
    func fetchData() async {
        print("Fetching movies??")
        movies = await serviceFetcher.fetchTrakts()
        guard let allMovies = movies?.allMovies else { return }
        
        // FIXME: You can work on the order of async list and images appropriately. Not a biggie but the order does matter when getting last watch movies or tv show assets.
        moviesViewData = try? await serviceFetcher.fetchAllRecentMoviesDetailsWithImagesAsync(movies: allMovies)
    }
    
    func listenerToChangesDebug() {
        $moviesViewData.sink { _ in
            print("Changes in ViewModel")
        }
        .store(in: &cancellables)
        
        $traktTVApi.sink { _ in
            print("Changes in traktTVApi")
        }
        .store(in: &cancellables)
        
        $displaySafari.sink { chane in
            print("Changes in displaySafari: \(chane)")
        }
        .store(in: &cancellables)
    }
    
    
    func showSignInUser() {
        displaySafari = true
        
//        presentLogIn()

    }
    
//    func showLoginSafari() {
//        print("Here in state change")
//        presentLogIn()
//    }
    
    func refreshUI() {
        print("In refresh UI ?")
        
//        displaySafari = false
//        dismissLogIn()
        // TODO: Append the network calls with appropriate signed in User and make all the network request using Oauth instead of my personal access tokens.
        self.traktTVApi = "Success Callback!"
    }
    
 
}

import SafariServices
private extension TraktViewModel {
    func presentLogIn() {
        guard let oauthURL = TraktManager.sharedManager.oauthURL else { return }
        print("In PresentLoginIn")
        let vc = SFSafariViewController(url: oauthURL)
        UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
        
    }
    
    
    func dismissLogIn() {

        UIApplication.shared.firstKeyWindow?.rootViewController?.dismiss(animated: true)
        
    }
    
    func setupObservers() {
        print("$$$$ Setup Observers ")
//        traktCallback?.cancel()
//        NotificationCenter.default.removeObserver(self, name: .TraktSignedIn, object: nil)
//        
//        NotificationCenter.default.addObserver(forName: .TraktSignedIn, object: nil, queue: nil) { [weak self] _ in
//            UIApplication.shared.firstKeyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
//            print("Did we get trackSigned In observer returned! ")
//            self?.displaySafari = false
////            self?.refreshUI()
//        }
        
        NotificationCenter.default.publisher(for: .TraktSignedIn)
            .sink { [weak self] _ in
                UIApplication.shared.firstKeyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
                print(" Combine: :: Did we get trackSigned In observer returned! ")
                self?.displaySafari = false
            }.store(in: &cancellables)
            
        
        $displaySafari
            .filter { $0 }
            .sink { _ in self.presentLogIn() }
            .store(in: &cancellables)
        
        $displaySafari
            .dropFirst()
            .filter { !$0 }
            .sink { _ in self.refreshUI() }
            .store(in: &cancellables)
        
    }
}



