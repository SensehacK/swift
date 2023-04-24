//
//  ContentView.swift
//  swiftUI-images-concurrency
//
//  Created by Kautilya Save on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    
    let imagesArr: [String] = [
    "https://picsum.photos/600",
    "https://picsum.photos/500",
    "https://picsum.photos/530",
    "https://picsum.photos/400",
    "https://picsum.photos/690",
    "https://picsum.photos/800",
    "https://picsum.photos/840",
    "https://picsum.photos/240"
    ]
    
    
    @StateObject var vm: ImageNetwork = ImageNetwork()
    
    var body: some View {
        VStack {

            ScrollView {
                
//                ForEach(imagesArr, id: \.self) { imageURL in
//                    if let images = URL(string:imageURL) {
//                        AsyncImage(url: images)
//                    }
//                }
                
                ForEach(vm.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(height: 60)
                }
                .onAppear {
                    Task {
                        try? await vm.fetchImages()
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
