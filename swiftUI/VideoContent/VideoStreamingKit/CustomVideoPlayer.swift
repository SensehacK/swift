//
//  CustomVideoPlayer.swift
//  VideoStreamingKit
//
//  Created by Kautilya Save on 4/22/23.
//

import AVFoundation
import AVKit

public class CustomVideoPlayer: VideoPlayerProtocol {

    

    private let playerViewController = AVPlayerViewController()
    private let avPlayer = AVPlayer()
    
    private lazy var playerView: UIView = {
        let view = playerViewController.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    public init() {
        
    }
    
    
    // MARK: - Public Interface
    
    public func addVideo(view: UIView) {
        view.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        
    }
    
    public func pauseVideo() {
        print("Pause")
    }
    
    public func playVideo() {
        print("Play Video")
        playerViewController.player?.play()
    }
    
    public func configureVideo(url: URL) {
        print("Configure $$$$$$$$$")
        
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        avPlayer.replaceCurrentItem(with: playerItem)
        playerViewController.player = avPlayer
        playVideo()
    }
    
    
}
