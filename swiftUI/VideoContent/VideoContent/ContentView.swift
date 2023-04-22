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
            
//            VideoView()
            
            VideoView(video: vm.videoURL)
            
            Text("Hello Kautilya")
//            Image(systemName: "checkmark")
//                .resizable()
//                .frame(width: .infinity, height: 350)
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
