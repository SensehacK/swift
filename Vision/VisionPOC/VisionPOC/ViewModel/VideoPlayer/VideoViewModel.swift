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
    }
    
    
    
    func setupObservers() {

        
    }
    
    func initializePlayer() {
       
        if let videoData  {
            createPlayer(.remote(url: videoData.body))
//            createPlayer(url: videoData.body)
        } else {
            let dummyVideoData = VideoData(body: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")
            let dummy3DVideo = VideoData(body: "https://devstreaming-cdn.apple.com/videos/streaming/examples/historic_planet_content_2023-10-26-3d-video/DoVi_P20_34000_t2160p/prog_index.m3u8")

        
//            let tempVideo = createLocalVideoAsset() ?? dummyVideoData
            let tempVideo = dummy3DVideo // dummyVideoData
            videoData = tempVideo
//            createPlayer(.local(file: tempVideo.body))
            createPlayer(.remote(url: tempVideo.body))
        }
        
                
        
        
    }
    
    
    func createLocalVideoAsset() -> VideoData? {
        // bbb_sunflower_1080p_30fps_stereo_abl
        // bbb_sunflower_2160p_60fps_stereo_abl
        let path1 = "bbb_sunflower_1080p_30fps_stereo_abl"
        let path1_ext = "mp4"
        let path2 = "TheOffice-S06xE13"
        let path2_ext = "avi"
        guard let path = Bundle.main.path(forResource: path1, ofType: path1_ext) else {
            debugPrint("video.m4v not found")
            return nil
        }
        
        let videoData = VideoData(body: path)
        return videoData
    }
    
    func createPlayer(_ source: VideoSource) {
        print("In create player!")
        let customAVController = AVPlayerViewController()
        var playbackURL: URL?
        switch source {
            
        case .local(let filePath):
            playbackURL = URL(fileURLWithPath: filePath)
        
            
        case .remote(let urlPath):
            playbackURL = URL(string: urlPath)
        }
        
//
//            print("Local Player")
//            player = PlayerView(itemURL: localURL, controller: customAVController)
        
        if let playbackURL {
            print("Created Player")
            player = PlayerView(itemURL: playbackURL, controller: customAVController)
        } else {
            print("FAilure creating playback")
        }
        
    }
    
    
}


struct VideoData: Identifiable {
    var id: String {
        return UUID().uuidString
    }
    let body: String
}


enum VideoSource {
    case local(file: String)
    case remote(url: String)
}
