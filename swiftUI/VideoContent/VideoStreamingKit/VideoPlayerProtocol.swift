//
//  VideoPlayerProtocol.swift
//  VideoStreamingKit
//
//  Created by Kautilya Save on 4/22/23.
//

import UIKit
import SwiftUI
import AVFoundation
import _AVKit_SwiftUI


public protocol VideoPlayerProtocol {
    
    func addVideo(view: UIView)
    
    func pauseVideo()
    
    func playVideo()
    
    func configureVideo(url: URL)

}


public struct VideoView: View {
    public var url: String
    public var width: CGFloat
    public var height: CGFloat
    
    public var autoPlay: Bool
    
    @State private var player = AVPlayer()
    
    public init(url: String,
                width: CGFloat = .infinity,
                height: CGFloat = .infinity,
                autoPlay: Bool = false) {
        print(url)
        self.url = url
        self.width = width
        self.height = height
        self.autoPlay = autoPlay
    }
    
    public var body: some View {
        VideoPlayer(player: player)
            .frame(width: width, height: height)
//            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Unwrapping optional
                if let link = URL(string: url) {
                    // Setting the URL of the video file
                    player = AVPlayer(url: link)
                    
                    if autoPlay {
                        // Play the video
                        player.play()
                    }
                    
                }
            }
    }
}
