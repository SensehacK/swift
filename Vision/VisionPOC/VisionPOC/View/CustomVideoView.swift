//
//  CustomVideoView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import SwiftUI
import AVKit


struct CustomVideoView: View {
    
    
    //    @Binding var player: PlayerView?
    @Binding var videoData: VideoData?
    
    
    var body: some View {
        if let videoData,
           let playbackURL = URL(string: videoData.body) {
            let customAVController = AVPlayerViewController()
//            PlayerView(itemURL: playbackURL, controller: customAVController)
            PlayerView()
            
        } else {
            Text("Can't play video")
            //            player
            
        }
        
    }
}
