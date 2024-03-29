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
    
    @State private var player = AVPlayer()
    @Binding public var statplay: Int
    @Binding var isPlaying: Bool
    @Binding var start: Bool
    @Binding var stop: Bool
    @Binding var explicitURL: String
    
    public init(url: String,
                width: CGFloat = .infinity,
                height: CGFloat = .infinity,
                autoPlay: Bool = false,
                statPlay: Binding<Int>,
                isPlaying: Binding<Bool>,
                start: Binding<Bool>,
                stop: Binding<Bool>,
                explicitURL: Binding<String>) {
//        print(url)
        self.url = url
        self.width = width
        self.height = height
        self.autoPlay = autoPlay
        self._statplay = statPlay
        self._isPlaying = isPlaying
        self._start = start
        self._stop = stop
        self._explicitURL = explicitURL
    }
    
    public var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                if autoPlay {
                    initPlayer(url: url)
                    startPlaying()
                }
            }
            .onDisappear {
                pausePlaying()
            }
            .onChange(of: isPlaying) { _ in
                print("Name changed to")
                isPlaying ? startPlaying() : pausePlaying()
                
            }
            .onChange(of: start) { _ in
                print("Start \(start)")
                let chooseURL: String = explicitURL.count > 0 ? explicitURL : url
                start ? initPlayer(url: chooseURL) : deinitPlayer()
            }
            .onChange(of: stop) { _ in
                print("stop")
                stop ? stopPlayback() : startPlaying()
            }
            .task {
                statplay = PlayerState.isNotLoading.rawValue
            }

    }
    
    
    func initPlayer(url: String) {
        print("Init Player()")
        statplay = PlayerState.isLoading.rawValue
        print("$$$$$$$$$$$$$")
        print(url)
        
//        let httpsurl = url.replacingOccurrences(of: "http", with: "https")
//        print(httpsurl)
        if let link = URL(string: url) {
            statplay = PlayerState.isVideoAvailable.rawValue
            player = AVPlayer(url: link)
        } else {
            statplay = PlayerState.isVideoUnAvailable.rawValue
        }
    }
    
    func startPlaying() {
        print("Start playing")
        // Play the video
        player.play()
        statplay = PlayerState.isPlaying.rawValue
        isPlaying = true
        stop = false
    }
    
    func pausePlaying() {
        print("Pause Playing!")
        player.pause()
        statplay = PlayerState.isPaused.rawValue
        isPlaying = false
    }
    
    func stopPlayback() {
        print("Stopping Playback")
        statplay = PlayerState.isStopped.rawValue
        isPlaying = false
        player.stop()
    }
    
    
    func deinitPlayer() {
        print("Deinit Player")
        statplay = PlayerState.isNotLoading.rawValue
        player.replaceCurrentItem(with: nil)
    }
}
