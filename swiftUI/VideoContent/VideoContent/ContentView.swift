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
    @State var start = false
    @State var stop = false
    
    var body: some View {
        VStack {
            Text("\(playerState)")
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
                    start.toggle()
                } label: {
                    Text(start ? "Unload" : "Load")
                }
                
                Button {
                    stop.toggle()
                } label: {
                    Text(stop ? "Start" : "Stop")
                }
            }

//            VideoView(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", autoPlay: true, statPlay: $playerState)
            VideoView(url: vm.videoURL, autoPlay: false, statPlay: $playerState, isPlaying: $play, start: $start, stop: $stop)
            VideoView(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                      autoPlay: false, statPlay: $playerState, isPlaying: $play, start: $start, stop: $stop)

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
