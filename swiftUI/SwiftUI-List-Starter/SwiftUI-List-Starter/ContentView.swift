//
//  ContentView.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct ContentView: View {
    
    var videos: [Video] = VideoList.topTen
    
    
    var body: some View {
        NavigationView {
            
            List(videos, id: \.id) { video in
                
                NavigationLink(destination: DetailView(video: video)) {
                    CustomCell(video: video)
                }
                
//                CustomCell(video: video)
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

struct CustomCell: View {
    
    var video: Video

    var body: some View {
        HStack {
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(10)
                .padding(.vertical, 4)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(video.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(video.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
            }
        }
    }
}


struct DetailView: View {
    
    var video: Video
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Spacer()
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(20)
            
            Text(video.title)
                .font(.custom("SF Pro", size: 20))
                .fontWeight(.bold)
                .lineLimit(2)
            
            
            HStack(spacing: 20) {
                Label("\(video.viewCount)", systemImage: "eye.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            
            Text(video.description)
                .font(.body)
            
            Spacer()
            HeroButton(title: "Watch it on YouTube!", url: video.url)
            
            
        }
        .padding(.horizontal)
        
    }
    
    
    
}

struct HeroButton: View {
    
    var title: String
    var url: URL
    
    var body: some View {
        Link(destination: url) {
            Text(title)
                .bold()
                .font(.title)
                .frame(width: 350, height: 50)
                .background(Color(.systemRed))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
