//
//  PlayerView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import SwiftUI
import AVKit

@MainActor
struct PlayerView: UIViewControllerRepresentable {
    
//    let id = UUID().uuidString
//    let itemURL: URL
//    var controller: AVPlayerViewController?
//    var player: AVPlayer = AVPlayer()
//    @EnvironmentObject private var viewModel: VideoViewModel
    @Environment(VideoViewModel.self) private var viewModel
    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        
//        
//        
//        
//        let controller: AVPlayerViewController = AVPlayerViewController()
//        controller.player = player
//        controller.player?.replaceCurrentItem(with: AVPlayerItem(url: itemURL))
//        
////        controller.player?.play()
//        return controller
//    }
    
    @MainActor
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        // Create a player view controller.
        let controller = viewModel.makePlayerViewController()
        
//        if let playbackURL: URL = viewModel.playbackURL {
//            print("Got PlaybackURL!")
//            let playerItem = AVPlayerItem(url: playbackURL)
//            controller.player?.replaceCurrentItem(with: playerItem)
//            logger.debug("🍿 \(playbackURL) enqueued for playback.")
//        }
        
        viewModel.loadVideo()
//        controller.player = player1111
        
        
//        controller.player?.play()
        return controller
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}


//extension PlayerView : Equatable {
//    
//}

import os
/// A global logger for the app.
let logger = Logger()
