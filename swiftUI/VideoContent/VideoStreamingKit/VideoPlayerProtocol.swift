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
    public var video: String
    @State private var player = AVPlayer()
    
    public init(video: String) {
        print(video)
        self.video = video
    }
    
    public var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Unwrapping optional
                if let link = URL(string: video) {
                    // Setting the URL of the video file
                    player = AVPlayer(url: link)
                    
                    // Play the video
                    player.play()
                }
            }
    }
}
