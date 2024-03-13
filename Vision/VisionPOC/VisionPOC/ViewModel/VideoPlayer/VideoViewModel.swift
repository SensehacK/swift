//
//  VideoViewModel.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import AVFoundation
import AVKit
import Combine


class VideoViewModel: ObservableObject {
    
    // U
    @Published var player: PlayerView?
    
    @Published var videoData: VideoData?
    
    var cancellables = Set<AnyCancellable>()
    
    init(player: PlayerView? = nil,
         videoData: VideoData? = nil) {
        self.player = player
        self.videoData = videoData
//        createPlayer()
    }
    
    
    
    func setupObservers() {
        
//        $videoData
//            .sink { _ in
//                self.createPlayer()
//            }
//            .store(in: &cancellables)
        
    }
    
    func createPlayer() {
        print("In create player!")
        let customAVController = AVPlayerViewController()
        videoData = VideoData(body: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")
        if let videoData,
           let playbackURL = URL(string: videoData.body) {
            print("Created Player")
            player = PlayerView(itemURL: playbackURL, controller: customAVController)
        }
        
    }
    
    
}


struct VideoData: Identifiable {
    var id: String {
        return UUID().uuidString
    }
    let body: String
}
