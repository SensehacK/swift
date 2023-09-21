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
        GridItem(.adaptive(minimum: 200, maximum: 400))
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
    
    let userMovies: [TraktConsumableView]
//    let userMovies: TraktMovies
    
    var body: some View {
        VStack {
            
            Text("Your Movies")
            
            
            LazyVGrid(columns: layout) {

                ForEach(userMovies, id: \.id) { movie in
                    
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8, content: {
                        Text(movie.title)
                        
                        
                        Image(uiImage: movie.posterImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                    })
                    
                }
                
//                ForEach(names, id: \.self) { name in
//                    Image(systemName: name)
//                        .renderingMode(.original)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 200, height: 100, alignment: .center)
//                    
//                }
            }
            
            
            
        }
        .navigationTitle("Content")
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    MoviesGrid(userMovies: [])
}
