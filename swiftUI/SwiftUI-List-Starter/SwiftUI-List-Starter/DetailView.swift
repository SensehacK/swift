//
//  DetailView.swift
//  SwiftUI-List-Starter
//
//  Created by Kautilya Save on 4/13/23.
//

import SwiftUI

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
