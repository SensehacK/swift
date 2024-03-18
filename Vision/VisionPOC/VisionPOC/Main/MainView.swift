//
//  MainView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI

#if os(visionOS)
import RealityKit
import RealityKitContent
#endif
import SafariServices

struct MainView: View {
    
    
    @EnvironmentObject private var viewModel: TraktViewModel
    @State var viewDidLoad: Bool = false

    var body: some View {
        VStack {

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
                
                Text("Hello Sensehack!")
                
                Button("Sign In Trakt TV") {
                    viewModel.displaySafari = true
                }
            }
            
        }
        .navigationTitle("Content")
        .task {
            print("AHGAG23")
            if !viewDidLoad {
                print("HASE")
//                await viewModel.fetchData()
                viewDidLoad = true
            }
        }
        .padding()
    }
}

#if os(visionOS)
#Preview(windowStyle: .automatic) {
    MainView()
}
#endif

#if !os(visionOS)
#Preview {
    MainView()
}
#endif
