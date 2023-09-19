//
//  MoviesGrid.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftUI

struct MoviesGrid: View {
    
    // Layout Guide
    
    let layout = [
        GridItem(.adaptive(minimum: 160, maximum: 400))
    ]
    
    var names: [String] = ["heart.fill",
                           "star.fill",
                           "circle.hexagongrid.fill",
                           "leaf.fill",
                           "sun.max.fill",
                           "ladybug.fill",
                           "moon.fill",
                           "sparkles",
                           "snowflake"
                           
    ]
    
    let userMovies: TraktMovies
    
    
    var body: some View {
        VStack {
            
            Text("Your Movies")
            
            
            LazyVGrid(columns: layout) {
                ForEach(0..<20) {
                    Text("Movie # \($0)")
                    //                    AsyncImage(url: <#T##URL?#>, scale: <#T##CGFloat#>, content: <#T##(Image) -> View#>, placeholder: <#T##() -> View#>)
                }
                
                ForEach(names, id: \.self) { name in
                    Image(systemName: name)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 100, alignment: .center)
                    
                }
            }
            
            
            
        }
        .navigationTitle("Content")
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    MoviesGrid(userMovies: [])
}
