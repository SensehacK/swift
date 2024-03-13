//
//  PlayerView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import SwiftUI
import AVFoundation
import AVKit


struct PlayerView: UIViewControllerRepresentable, Identifiable {
    
    let id = UUID().uuidString
    let itemURL: URL
    var controller: AVPlayerViewController = AVPlayerViewController()
    var player: AVPlayer = AVPlayer()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        controller.player = player
        controller.player?.replaceCurrentItem(with: AVPlayerItem(url: itemURL))
//        controller.player?.play()
        return controller
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}


extension PlayerView : Equatable {
    
}
