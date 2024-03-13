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
        GridItem(.adaptive(minimum: 300, maximum: 800))
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
        
        
        ScrollView {
            VStack {
                
                Text("Your Movies")
                
                
                LazyVGrid(columns: layout) {
                    
                    ForEach(userMovies, id: \.id) { movie in
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8, content: {
                            Text(movie.title)
                            
                            
                            Image(uiImage: movie.posterImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 700, height: 500)
                        })
                        
                    }
                    
                    /* System Emojis Trials
                    ForEach(names, id: \.self) { name in
                        Image(systemName: name)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 100, alignment: .center)
                        
                    }
                     */
                }
                
                
                
            }
            .navigationTitle("Content")
            .padding()
        }
    }
}


// MARK: - Preview
#if os(visionOS)
#Preview(windowStyle: .automatic) {
    MoviesGrid(userMovies: [])
}
#endif

#if !os(visionOS)
#Preview {
    MoviesGrid(userMovies: [])
}
#endif

