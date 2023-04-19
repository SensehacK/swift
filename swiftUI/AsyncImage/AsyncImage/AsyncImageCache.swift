//
//  AsyncImageCache.swift
//  AsyncImage
//
//  Created by Kautilya Save on 4/19/23.
//

import SwiftUI

struct AsyncImageCache<T>: View where T:View {
    
    private let url: String
    private let content: (AsyncImagePhase) -> T
    
    init(url: String,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> T) {
        self.url = url
        self.content = content
    }
    
    var body: some View {
        returnImageView(url: url)

    }
    
    
    func returnImageView(url: String) -> some View {
//        if let url = URL(string: url) {
//            Text("Hello")
//            AsyncImage(url: url) { phase in
//                cacheAndRender(phase:phase)
//            }
//        } else {
//            Text("World!")
//        }
//
        
        
//        AsyncImage(url: URL(string: url)!) { phase in
////            cacheAndRender(phase:phase)
//            content(phase)
//        }
        cacheAndRender()
        
//        return Text("No Image22")
     
    }
    
    
    func cacheAndRender() -> some View {
//            if case .success(let image) = phase {
//                ImageCache[url] = image
//            }
//            guard let url = URL(string: url) else { return Text("EmptyView") }

            AsyncImage(url:  URL(string: url)!) { phase in
                //            cacheAndRender(phase:phase)
    //            AnyView(content(phase))
                content(phase)
                        }
//        }
//        return content(phase)
//        return Text("ASAT")
        }
}
