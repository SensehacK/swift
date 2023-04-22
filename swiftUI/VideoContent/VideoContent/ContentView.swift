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
    
    
    var body: some View {
        VStack {
            
            VideoView(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", autoPlay: true)
            VideoView(url: vm.videoURL, autoPlay: true)

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
