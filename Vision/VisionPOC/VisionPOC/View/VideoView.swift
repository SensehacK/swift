//
//  VideoView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import SwiftUI
import AVKit

struct VideoView: View {
    
//    @State var videoData: VideoData?

//    @StateObject var videoVM: VideoViewModel = VideoViewModel()
    
//    @Environment(VideoViewModel.self) private var videoVM
    
//    @EnvironmentObject private var videoVM: VideoViewModel
    
    @Environment(VideoViewModel.self) private var videoVM
    
//    @State var player: AVPlayer?
    //    let mediaView: TraktConsumableView
////    let name: String
    
//    @State var showVideo: Bool = false
    
    
    var body: some View {
        
        switch videoVM.presentation {
            
        case .fullWindow:
            videoVM.player
            
        case .showUI:
            Button("Play Full Video") {
                print("Playing full video")
                videoVM.initializePlayer()
            }
            //            .onChange(of: videoVM.avPlayer, {
            //                 videoVM.play()
            //            })
            
        }
       
        
        
        
//        if let playerView = videoVM.player {
//            playerView
//        } else {
//            Button("Play Full Video") {
//                print("Playing full video")
//    //            if let videoData {
//    //                videoVM.videoData = videoData
//    //            }
//                videoVM.initializePlayer()
//    //            videoVM.player
//            }
//            .onChange(of: videoVM.avPlayer, {
//                 // Auto Play
//                 videoVM.play()
//            })
//        }
        
        
//        .onChange(of: videoVM.player, {
//            // Auto Play
//            videoVM.play()
//        })
//        .fullScreenCover(item: $showVideo,
//                         onDismiss: didDismiss) { playerView in
//            playerView
//        }
        
//         .fullScreenCover(item: $videoVM.player,
//                          onDismiss: didDismiss) { playerView in
//             playerView
//         }

    }
    
    
    @MainActor func didDismiss() {
        // Handle the dismissing action.
        print("Did dismiss called.")
        videoVM.dismissVideo()
    }

}



#if os(visionOS)
#Preview(windowStyle: .automatic) {
    let videoData: VideoData = VideoData(body: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
//    VideoView(videoData: videoData)
    VideoView()
}
#endif



