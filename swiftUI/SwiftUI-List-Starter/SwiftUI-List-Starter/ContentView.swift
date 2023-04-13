//
//  ContentView.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct ContentView: View {
    
    // Dummy Model
    var videos: [Video] = VideoList.topTen
    
    var body: some View {
        NavigationView {
            List(videos, id: \.id) { video in
                NavigationLink(destination: DetailView(video: video)) {
                    VideoCell(video: video)
                }
            }
            .navigationTitle("Youtuber's iOS Top Ten")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        DetailView(video: VideoList.topTen.first!)
    }
}

