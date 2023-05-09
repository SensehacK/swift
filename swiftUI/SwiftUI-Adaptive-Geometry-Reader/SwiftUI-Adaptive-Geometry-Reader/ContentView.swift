//
//  ContentView.swift
//  SwiftUI-Adaptive-Geometry-Reader
//
//  Created by Kautilya Save on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            AdaptiveContainerView {
                
                AsyncImage(url: URL(string: "https://mcdn.wallpapersafari.com/medium/7/45/3U5Jpx.jpeg")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                } placeholder: {
                    ProgressView()
                }
    //            Group {
                    VStack {
    //                    Group {
    //                        AsyncImage(url: URL(string: "https://mcdn.wallpapersafari.com/medium/7/45/3U5Jpx.jpeg"))
    //                    }
    //                    .frame(width: UIScreen.main.bounds.width)
    //
                            
                        

                        VStack {
                            Text(UIConstants.shanksText)
                        }
                        .padding()
                        
                    }
                    .padding()
    //            }
            }.navigationTitle("Shanks")
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct UIConstants {
    static let shanksText = """
"Red-Haired" Shanks,[9] commonly known as just "Red Hair",[12] is the chief[5] of the Red Hair Pirates[2] and one of the Four Emperors that rule over the New World.[3]

Sailing with the Roger Pirates since he was an infant, Shanks would begin his pirate career on their ship as an apprentice alongside Buggy, before forming his own crew following Roger's death.[4]
"""
}
