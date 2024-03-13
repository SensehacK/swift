//
//  VideoView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import SwiftUI
import AVKit

struct VideoView: View {
    
    @State var videoData: VideoData?
    
    @State var player: PlayerView?
    
    @StateObject var videoVM: VideoViewModel = VideoViewModel()
    
    var body: some View {
        
        
        if let videoData,
           let url = URL(string: videoData.body) {
            PlayerView(itemURL: url)
        }
        
        
        Button("Play Full Video") {
            print("Playing full video")
            videoVM.createPlayer()
        }
        .onChange(of: videoVM.player, {
            // Auto Play
            videoVM.player?.player.play()
        })
        .fullScreenCover(item: $videoVM.player,
                         onDismiss: didDismiss) { playerView in
            playerView
        }

    }
    
    
    func didDismiss() {
        // Handle the dismissing action.
        print("Did dismiss called.")
    }
    
    
    func createPlayer(playbackURL: URL) -> any View {
        let customAVController = AVPlayerViewController()
        player = PlayerView(itemURL: playbackURL, controller: customAVController)
        return player
    }
}



#if os(visionOS)
#Preview(windowStyle: .automatic) {
    let videoData: VideoData = VideoData(body: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    VideoView(videoData: videoData)
}
#endif



