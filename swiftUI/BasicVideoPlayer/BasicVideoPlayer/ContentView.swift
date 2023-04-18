//
//  ContentView.swift
//  BasicVideoPlayer
//
//  Created by Kautilya Save on 4/18/23.
//

import SwiftUI
import AVKit

struct SimpleVideoPlayer: View {
    
    private let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
        .onAppear() {
            player.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleVideoPlayer()
    }
}
