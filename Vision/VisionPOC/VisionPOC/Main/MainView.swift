//
//  MainView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MainView: View {
    
    
    @EnvironmentObject private var viewModel: TraktViewModel
    
    
//    @StateObject var viewModel: TraktViewModel = TraktViewModel()
    @State var viewDidLoad: Bool = false
    
    
    var body: some View {
        VStack {
            if let movies = viewModel.movies {
                Text("See this data ???")
                Text(movies.firstMovieName ?? "No Movie damn!")
            }
            Text("Hello Sensehack!")
            
            Button("Sign In Trakt TV") {
                viewModel.showSignInUser()
            }
            
            if let success = viewModel.traktTVApi {
                Text(success)
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
            viewModel.showLoginSafari()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    MainView()
}
