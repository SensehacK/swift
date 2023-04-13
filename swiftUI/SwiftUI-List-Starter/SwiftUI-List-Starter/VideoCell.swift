//
//  VideoCell.swift
//  SwiftUI-List-Starter
//
//  Created by Kautilya Save on 4/13/23.
//

import SwiftUI


struct VideoCell: View {
    
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
