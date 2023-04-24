//
//  ContentView.swift
//  swiftUI-images-concurrency
//
//  Created by Kautilya Save on 4/23/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var vm: ImageNetwork = ImageNetwork()
    
    @State var loadImagesAsync = true
    
    var body: some View {
        VStack {

            ScrollView {
                
                if loadImagesAsync {
                    VStack {
                        Text("Async")
                        ForEach(vm.imagesAsync, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(height: 500)
                        }
                    }
                    .task {
                        print("Async Image")
                        await vm.fetchImagesAsync()
                    }
                } else {
                    VStack {
                        Text("Sync")
                        ForEach(vm.images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(height: 10)
                        }
                    }
                    .task {
                        print("Fetch Image")
                        await vm.fetchImages()
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
