//
//  VisionPOCApp.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI

@main
struct VisionPOCApp: App {
    
    // App Delegate
    @UIApplicationDelegateAdaptor var delegate: VSPAppDelegate
    
    @StateObject var viewModel: TraktViewModel = TraktViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .onOpenURL { (url) in
                    // Handle url here
                    print("Hello Vision POC SwiftUI - Did I get a callback here!")
                    // Parse the URL callback from Trakt API Oauth
                    TokenCapture.parseURLSchemeToExtractToken(url: url)
//                    viewModel.displaySafari = false
                }
        }
    }
}
