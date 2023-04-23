//
//  ContentView.swift
//  VideoContent
//
//  Created by Kautilya Save on 4/22/23.
//

import SwiftUI
import VideoStreamingKit

struct ContentView: View {
    
    @StateObject var vm: ViewContentViewModel = ViewContentViewModel()
    @State var playerState: Int = 0
    @State var play = false
    @State var load = false
    @State var stop = false
    
    @State var videoURL = ""
    
    var body: some View {
        VStack {
//            Text("\(playerState)")
            TextField(text: $videoURL) {
                Text("Enter Video URL here!")
            }
            
            if let playerStateDesc = PlayerState(rawValue: playerState) {
                Text("Current state \(playerStateDesc.description())")
            }
            HStack(spacing: 20) {
                
                Button {
                    play.toggle()
                } label: {
                    Text(play ? "Pause" : "Play")
                }
                
                Button {
                    load.toggle()
                } label: {
                    Text(load ? "Unload" : "Load")
                }
                
                Button {
                    stop.toggle()
                } label: {
                    Text(stop ? "Start" : "Stop")
                }
            }

//            VideoView(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", autoPlay: true, statPlay: $playerState)
//
//            VideoView(url: vm.videoURL,
//                      autoPlay: false,
//                      statPlay: $playerState,
//                      isPlaying: $play,
//                      start: $load,
//                      stop: $stop,
//                      explicitURL: $videoURL)
            
            VideoView(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                      autoPlay: false,
                      statPlay: $playerState,
                      isPlaying: $play,
                      start: $load,
                      stop: $stop,
                      explicitURL: $videoURL)
            
            VideoView(url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8",
                      autoPlay: false,
                      statPlay: $playerState,
                      isPlaying: $play,
                      start: $load,
                      stop: $stop,
                      explicitURL: $videoURL)
            
            VideoView(url: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8",
                      autoPlay: false,
                      statPlay: $playerState,
                      isPlaying: $play,
                      start: $load,
                      stop: $stop,
                      explicitURL: $videoURL)
            
            
        

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
