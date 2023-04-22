//
//  ViewContentViewModel.swift
//  VideoContent
//
//  Created by Kautilya Save on 4/22/23.
//

import Foundation
import VideoStreamingKit
import UIKit
import SwiftUI
import AVKit


class ViewContentViewModel: ObservableObject {
    
    @Published var videoView: UIView = UIView()
    @Published var videoURL: String = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    
    let url : [String] = [
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
    ]
    
    private let videoPlayer: CustomVideoPlayer = CustomVideoPlayer()
    
    
    
    init() {
        
//        setupViewPlayer()
        
    }
    
    
    func setupViewPlayer() {
        
        
        videoPlayer.addVideo(view: videoView)
        
        let userCustomURL = URL(string: videoURL)
        
        guard let randomURLString = url.randomElement(),
              let url = URL(string: randomURLString) else {
            print("Failure parsing URL")
            return
        }
        
        videoPlayer.configureVideo(url: url)
        
        
    }
    
    
    func playVideo() {
        videoPlayer.playVideo()
    }
    
    func pauseVideo() {
        videoPlayer.pauseVideo()
    }
    
    func clearVideo() {
        videoURL = ""
    }
    
    
    
}


struct VideoPlayerUIKitBridge : UIViewControllerRepresentable {
    
    @Binding var player : AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayerUIKitBridge>) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resize
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayerUIKitBridge>) {
        
        
    }
}
