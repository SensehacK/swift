//
//  AsyncImageCache.swift
//  AsyncImage
//
//  Created by Kautilya Save on 4/19/23.
//

import SwiftUI

struct AsyncImageCache<T>: View where T: View {
    
    private let url: URL
    private let key: String
    private let content: (AsyncImagePhase) -> T
    
    init(url: URL,
         key: String = UUID().uuidString,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> T) {
        self.url = url
        self.key = key
        self.content = content
    }
    
    var body: some View {
        
        // Check for Cache Dictionary first
        if let cachedImage = CacheDictionary[key] {
            content(.success(cachedImage))
        } else {
            // Or else return the normal Network fetch image cache
            AsyncImage(url: url) { imagePhase in
                returnSuccessfulImageAndCache(phase: imagePhase)
            }
        }

    }
    
    
    func returnSuccessfulImageAndCache(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            CacheDictionary[key] = image
        }
        return content(phase)
    }
    
}




// Storing our cache in dictionary with Key Value pairs.
class CacheDictionary {
    static private var cache: [String: Image] = [:]

    static subscript(key: String) -> Image? {
        get {
            CacheDictionary.cache[key]
        }
        set {
            CacheDictionary.cache[key] = newValue
        }
    }
}
