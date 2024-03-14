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

    @StateObject var videoVM: VideoViewModel = VideoViewModel()
    
    var body: some View {
        
        Button("Play Full Video") {
            print("Playing full video")
            if let videoData {
                videoVM.videoData = videoData
            }
            videoVM.initializePlayer()
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

}



#if os(visionOS)
#Preview(windowStyle: .automatic) {
    let videoData: VideoData = VideoData(body: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    VideoView(videoData: videoData)
}
#endif



