//
//  VideoViewModel.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 3/13/24.
//

import AVFoundation
import AVKit
import Combine

@Observable 
class VideoViewModel:  Equatable {
    static func == (lhs: VideoViewModel, rhs: VideoViewModel) -> Bool {
//        lhs.videoData?.id == rhs.videoData?.id
        
        lhs.playbackURL == rhs.playbackURL
    }
        
    
    // U
    var player: PlayerView?
    var avPlayer: AVPlayer = AVPlayer()
//    var videoData: VideoData?
    
    private var playerViewController: AVPlayerViewController? = nil
    private var playerViewControllerDelegate: AVPlayerViewControllerDelegate? = nil
    
    var playbackURL: URL?
    
    var cancellables = Set<AnyCancellable>()
    
    
    /// The presentation in which to display the current media.
    private(set) var presentation: Presentation = .showUI
    
    init(player: PlayerView? = nil,
         videoData: VideoData? = nil) {
        self.player = player
//        self.videoData = videoData
    }
    
    
    
    func setupObservers() {

        
    }
    
    @MainActor 
    func initializePlayer() {
//        if let videoData  {
//            createPlayer(.remote(url: videoData.body))
////            createPlayer(url: videoData.body)
//        } else { }
        

            let dummyVideoData = VideoData(body: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")
            let dummy3DVideo = VideoData(body: "https://devstreaming-cdn.apple.com/videos/streaming/examples/historic_planet_content_2023-10-26-3d-video/DoVi_P20_34000_t2160p/prog_index.m3u8")
            
            guard let localPath = Bundle.main.path(forResource: "bbb1080p", ofType: "mp4") else {
                print("Couldnt load local video")
                return
            }
            let dummyLocalData = VideoData(body: localPath)
//            let dummySpatialVideo = VideoData(body: "")

//            let tempVideo = createLocalVideoAsset(type: .Bunny_SBS1080P) ?? dummyVideoData
//            let tempVideo =  dummyVideoData //  dummy3DVideo
//            let tempVideo = createLocalVideoAsset(type: .Bunny_SpatialMVHEVC) ?? dummyVideoData
//        let tempVideo = createLocalVideoAsset(type: .Office_AVI) ?? dummyLocalData
        let tempVideo = createLocalVideoAsset(type: LocalVideoType.Bunny_SpatialMVHEVC) ?? dummyLocalData
//            let tempVideo = createLocalVideoAsset(type: LocalVideoType.randomElement()) ?? dummyLocalData
//            videoData = tempVideo
            
            print("Video playback: \(tempVideo.body)")
            
            //
            createPlayer(.local(file: tempVideo.body))
//            createPlayer(.remote(url: tempVideo.body))
//        }
        
                
        
        
    }
    
    
    func createLocalVideoAsset(type : LocalVideoType) -> VideoData? {
        let filePath: String
        let filePathExt: String
        
        switch type {
        case .Bunny_SBS1080P:
            filePath = "bbb1080p"
            filePathExt = "mp4"
        
        case .Bunny_SBS2160P:
            filePath = "bbb2160p"
            filePathExt = "mp4"
            
        case .Bunny_SpatialMVHEVC:
            filePath = "new_spatial"
            filePathExt = "mov"
            
        case .jon_stewart:
            filePath = "jon_stewart"
            filePathExt = "mov"
        }
        
        
        guard let path = Bundle.main.path(forResource: filePath, ofType: filePathExt) else {
            debugPrint("video \(filePath).\(filePathExt) not found")
            return nil
        }
        
        let videoData = VideoData(body: path)
        return videoData
    }
    
    @MainActor
    func createPlayer(_ source: VideoSource) {
        print("In create player!")
        var playbackURL: URL?
        switch source {
            
        case .local(let filePath):
            playbackURL = URL(fileURLWithPath: filePath)

        case .remote(let urlPath):
            playbackURL = URL(string: urlPath)
        }
        
        if let playbackURL {
            print("Created Player")
            player = PlayerView()
            presentation = .fullWindow
            self.playbackURL = playbackURL
        } else {
            print("FAilure creating playback")
        }
        
    }
    
//    @MainActor
    func makePlayerViewController() -> AVPlayerViewController {
        let customAVController = AVPlayerViewController()
        let delegate = PlayerViewControllerDelegate(videoVM: self)
        customAVController.player = avPlayer
        customAVController.delegate = delegate
        playerViewController = customAVController
        playerViewControllerDelegate = delegate
        return customAVController
    }
    
    @MainActor
    func loadVideo() {
        guard let playbackURL else { return }
        // Create a new player item and set it as the player's current item.
        let playerItem = AVPlayerItem(url: playbackURL)
        
        // Set the new player item as current, and begin loading its data.
        avPlayer.replaceCurrentItem(with: playerItem)
        logger.debug("🍿 \(playbackURL) enqueued for playback.")
    }
    
    
    @MainActor
    func dismissVideo() {
        print("Dismiss Video? ??")
        avPlayer.replaceCurrentItem(with: nil)
        presentation = .showUI
        playbackURL = nil
        playerViewController = nil
        playerViewControllerDelegate = nil
        player = nil
    }
    
    func play() {
        avPlayer.play()
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



enum LocalVideoType : CaseIterable {
    case Bunny_SBS2160P
    case Bunny_SBS1080P
    case Bunny_SpatialMVHEVC
    case jon_stewart
}


// A coordinator that acts as the player view controller's delegate object.
final class PlayerViewControllerDelegate: NSObject, AVPlayerViewControllerDelegate {
    
    let videoVM: VideoViewModel
    
    init(videoVM: VideoViewModel) {
        print("In the PlayerViewControllerDelegate init.")
        self.videoVM = videoVM
    }
    
    #if os(visionOS)
    // The app adopts this method to reset the state of the player model when a user
    // taps the back button in the visionOS player UI.
    func playerViewController(_ playerViewController: AVPlayerViewController,
                              willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        Task { @MainActor in
            // Calling reset dismisses the full-window player.
            print("In the delegate function call.")
            videoVM.dismissVideo()
        }
    }
    #endif
}



/// The presentation modes the player supports.
enum Presentation {
    /// Indicates to present the player as a child of a parent user interface.
    case showUI
    /// Indicates to present the player in full-window exclusive mode.
    case fullWindow
}


extension CaseIterable {
    static func randomElement() -> AllCases.Element {
        guard Self.allCases.count > 0 else {
            fatalError("There must be at least one case in the enum")
        }
        return Self.allCases.randomElement()!
    }
}
