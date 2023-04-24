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
            
            if loadImagesAsync {
                AsyncLetCustomView(vm: vm)
            } else {
                SyncCustomView(vm: vm)
            }
            
            // Vs
            AsyncTaskGroupCustomView(vm: vm)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SyncCustomView: View {
    // Utilize @ObservedObject for passing ViewModel ref in extracted views.
    @ObservedObject var vm: ImageNetwork
    
    var body: some View {
        ScrollView {
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

struct AsyncLetCustomView: View {
    // Utilize @ObservedObject for passing ViewModel ref in extracted views.
    @ObservedObject var vm: ImageNetwork
    
    var body: some View {
        ScrollView {
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
        }
    }
}


struct AsyncTaskGroupCustomView: View {
    
    // Utilize @ObservedObject for passing ViewModel ref in extracted views.
    @ObservedObject var vm: ImageNetwork
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Async Task Group")
                ForEach(vm.imagesAsyncGroup, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
            .task {
                print("Async Task Group Image")
                await vm.fetchImagesTaskGroup()
            }
        }
    }
}
