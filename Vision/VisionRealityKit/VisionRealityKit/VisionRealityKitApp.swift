//
//  VisionRealityKitApp.swift
//  VisionRealityKit
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI

@main
struct VisionRealityKitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
