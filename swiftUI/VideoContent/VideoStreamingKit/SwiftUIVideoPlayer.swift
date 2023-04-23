//
//  SwiftUIVideoPlayer.swift
//  VideoStreamingKit
//
//  Created by Kautilya Save on 4/22/23.
//

import SwiftUI
import _AVKit_SwiftUI

public struct VideoView: View {
    public var url: String
    public var width: CGFloat
    public var height: CGFloat
    public var autoPlay: Bool
    
//    @Binding public var value: PlayerState
    
    @State private var player = AVPlayer()
//    @State var playerState: PlayerState = .isLoading
    @Binding public var statplay: Int
    @Binding var isPlaying: Bool
    @Binding var start: Bool
    @Binding var stop: Bool
    
//    @State var playerState: PlayerState = .isLoading
//
//    var playerStateProxy: Binding<Int> {
//            Binding<Int>(
//                get: {
//                    playerState.rawValue
//                },
//                set: {
//                    playerState = PlayerState(rawValue: $0) ?? PlayerState.isStopped
//                }
//            )
//        }
    
    public init(url: String,
                width: CGFloat = .infinity,
                height: CGFloat = .infinity,
                autoPlay: Bool = false,
//                value: PlayerState = .isLoading,
                statPlay: Binding<Int>,
                isPlaying: Binding<Bool>,
                start: Binding<Bool>,
                stop: Binding<Bool>) {
        print(url)
        self.url = url
        self.width = width
        self.height = height
        self.autoPlay = autoPlay
//        self.value = PlayerState.isLoading
//        self.statplay = 0
        self._statplay = statPlay
        self._isPlaying = isPlaying
        self._start = start
        self._stop = stop
//        self._value = $playerState
//        self.playerState = .isLoading
    }
    
    public var body: some View {
        VideoPlayer(player: player)
            .frame(width: .infinity, height: .infinity)
//            .edgesIgnoringSafeArea(.all)
            .onAppear {
//                initPlayer()
                isPlaying ? startPlaying() : pausePlaying()
//                startPlaying()
            }
            .onDisappear {
                pausePlaying()
            }
            .onChange(of: isPlaying) { _ in
                print("Name changed to")
                isPlaying ? startPlaying() : pausePlaying()
                
            }
            .onChange(of: start) { _ in
                print("Start")
                start ? initPlayer() : deinitPlayer()
                
            }
            .onChange(of: stop) { _ in
                print("stop")
                if stop {
                    stopPlayback()
                    deinitPlayer()
                }
                
            }
            .task {
                isPlaying ? startPlaying() : pausePlaying()
            }

    }
    
    
    func initPlayer() {
        print("Start Playing!")
        // Unwrapping optional
        if let link = URL(string: url) {
            print("Link")
            // Setting the URL of the video file
            player = AVPlayer(url: link)
        }
    }
    
    func startPlaying() {
        // Play the video
        player.play()
        statplay = PlayerState.isPlaying.rawValue
        isPlaying = true
    }
    
    func pausePlaying() {
        print("Pause Playing!")
        player.pause()
        statplay = PlayerState.isPaused.rawValue
        isPlaying = false
    }
    
    func stopPlayback() {
        player.stop()
    }
    
    
    func deinitPlayer() {
        player.replaceCurrentItem(with: nil)
    }
}
