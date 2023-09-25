//
//  iPadPOCApp.swift
//  iPadPOC
//
//  Created by Save, Kautilya on 9/21/23.
//

import SwiftUI
import SwiftData

@main
struct iPadPOCApp: App {
    
    // App Delegate
    @UIApplicationDelegateAdaptor var delegate: IPadAppDelegate
    
    @StateObject var viewModel: TraktViewModel = TraktViewModel()

    var body: some Scene {
        WindowGroup {
            iPadHomeView()
                .environmentObject(viewModel)
                .onOpenURL { (url) in
                    // Handle url here
                    print("Hello iPad POC SwiftUI - Did I get a callback here!")
                    // Parse the URL callback from Trakt API Oauth
                    TokenCapture.parseURLSchemeToExtractToken(url: url)
                    //                    viewModel.displaySafari = false
                }
        }
    }
}
