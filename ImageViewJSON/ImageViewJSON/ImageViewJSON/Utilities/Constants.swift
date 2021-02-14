//
//  Constants.swift
//  ImageViewJSON
//
//  Created by Sensehack on 2/13/21.
//


// MARK: App Constants Enumerations
enum Constants: String {
    // App Links strings
    case baseURL = "https://afternoon-bayou-28316.herokuapp.com/"
    case manifest = "manifest"
    case image = "image/"
    case apiKey = "33626b03-88b8-4c6e-af34-ac4e6f7faa7c"
    case apiHeader = "X-API-KEY"
    case imageViewSegue = "showImage"
    
}

enum HTTPStatusCode: Int {
    case statusSuccess = 200
    case statusUnauthorized = 401
}


enum Connection: String {
    case errorConnecting = "Error connecting the network"
    case statusUnavailable = "The resource is unavailable"
    case statusPermission = "The permission is denied"
    case statusUnauthorized = "The request is Unauthorized"
    case statusGateway = "Internal error occured. Bad gateway"
}
