//
//  Constants.swift
//  ImageViewJSON
//
//  Created by Sensehack on 2/13/21.
//

import UIKit

// MARK: App Constants Enumerations
enum Constants: String {
    // App Links strings
    case baseURL = "https://asd.herokuapp.com/"
    case manifest = "manifest"
    case image = "image/"
    case apiKey = "14152353232"
    case apiHeader = "21435"
    case imageViewSegue = "showImage"
    
}

enum HTTPStatusCode: Int {
    case statusSuccess = 200
    case statusUnauthorized = 401
}

enum Sizes: Int {
    case imageViewWidth = 300
    case imageViewHeight = 169
    case imageViewSpacer = 20
    case imageViewYCoordinate = 50
}

enum Connection: String {
    case errorConnecting = "Error connecting the network"
    case statusUnavailable = "The resource is unavailable"
    case statusPermission = "The permission is denied"
    case statusUnauthorized = "The request is Unauthorized"
    case statusGateway = "Internal error occured. Bad gateway"
}

struct AppConstants {
    // App Settings
    static var apiHeader = ""
    static var apiKey = ""
    static var baseURL = ""
}

class LaunchControl {
    
    func retrieveKeys() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            
            let keys = NSDictionary(contentsOfFile: path)
            if let apiKey:String = keys?["apiKey"] as? String {
                AppConstants.apiKey = apiKey
            }
            if let apiHeader:String = keys?["apiHeader"] as? String {
                AppConstants.apiHeader = apiHeader
            }
            if let baseURL:String = keys?["baseURL"] as? String {
                AppConstants.baseURL = baseURL
            }
       }
    }
}
