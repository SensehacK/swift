//
//  ContentView.swift
//  AsyncImage
//
//  Created by Kautilya Save on 4/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //            Image(systemName: "globe")
            //                .imageScale(.large)
            //                .foregroundColor(.accentColor)
            //            Text("Hello, world!")
            
            //            AsyncImage(url: URL(string: "https://robohash.org/hicveldicta.png")!) { phase in
            //                switch phase {
            //                case .success(let imag):
            //                    VStack {
            //                        imag
            //                    }
            //                default:
            //                    Text("Nothing")
            //                }
            //
            //            }
            VStack {
                
                AsyncImageCache(url: "https://robohash.org/hicveldicta.png") { phase in
                    switch phase {
                    case .success(let image):
                        HStack {
                            image
                        }
                    default:
                        Text("No Image")
                    }
                }
                
                AsyncImageCache(url: "https://i.dummyjson.com/data/products/1/1.jpg") { phase in
                    switch phase {
                    case .success(let image):
                        HStack {
                            image
                        }
                    default:
                        Text("No Image")
                    }
                }
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
