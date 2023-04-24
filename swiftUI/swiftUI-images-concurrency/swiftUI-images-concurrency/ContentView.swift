//
//  ContentView.swift
//  swiftUI-images-concurrency
//
//  Created by Kautilya Save on 4/23/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var vm: ImageNetwork = ImageNetwork()
    
    @State var loadImagesAsync = false
    
    var body: some View {
        VStack {
            AsyncCustomView(vm: vm, loadImagesAsync: loadImagesAsync)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AsyncCustomView: View {
    
    // Utilize @ObservedObject for passing ViewModel ref in extracted views.
    @ObservedObject var vm: ImageNetwork
    let loadImagesAsync: Bool
    
    var body: some View {
        ScrollView {
            
            if loadImagesAsync {
                VStack {
                    Text("Async")
                    ForEach(vm.imagesAsync, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                }
                .task {
                    print("Async Image")
                    await vm.fetchImagesAsyncLet()
                }
            } else {
                VStack {
                    Text("Sync")
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                }
                .task {
                    print("Fetch Image")
                    await vm.fetchImages()
                }
            }
            
            
            
        }
    }
}
