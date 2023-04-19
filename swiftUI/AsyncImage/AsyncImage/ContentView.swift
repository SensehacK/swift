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

//                AsyncImage(url: URL(string: "https://robohash.org/hicveldicta.png")!) { phase in
//                    switch phase {
//                    case .success(let imag):
//                        VStack {
//                            imag
//                        }
//                    default:
//                        Text("Nothing")
//                    }
//    
//                }
            VStack {
                if let url = URL(string: "https://robohash.org/hicveldicta.png") {
                    AsyncImageCache(url: url) { phase in
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
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
