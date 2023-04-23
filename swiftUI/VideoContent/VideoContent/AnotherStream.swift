//
//  AnotherStream.swift
//  VideoContent
//
//  Created by Kautilya Save on 4/23/23.
//

import SwiftUI
import AVKit


struct AnotherStream: View {
    private let player = AVPlayer(url: URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear() {
                player.play()
            }
    }
}

struct AnotherStream_Previews: PreviewProvider {
    static var previews: some View {
        AnotherStream()
    }
}
