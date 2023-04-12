//
//  Constants.swift
//  DogsCollectionView
//
//  Created by Sensehack on 3/26/21.
//

import Foundation

// URL: https://api.flickr.com/services/feeds/photos_public.gne?tags=puppy&format=json&nojsoncallback=1
struct AppConstants {
    // App Settings
    static var tags = "?tags="
    static var format = "&format="
    static var noCallback = "&nojsoncallback=1" // JSONP format
    static var baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
}
