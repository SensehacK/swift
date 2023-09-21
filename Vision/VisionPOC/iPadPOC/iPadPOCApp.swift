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
    
    @StateObject var viewModel: TraktViewModel = TraktViewModel()

    var body: some Scene {
        WindowGroup {
            iPadHomeView()
                .environmentObject(viewModel)
        }
    }
}
