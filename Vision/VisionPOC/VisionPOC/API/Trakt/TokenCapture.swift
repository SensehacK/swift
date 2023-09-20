//
//  TokenCapture.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation



struct TokenCapture {
    
    static func parseURLSchemeToExtractToken(url: URL) {
        let queryDict = queryDict(url: url) // Parse URL
        print("Hello in Parse URL Stream")
        if url.scheme == "visionp",
            let code = queryDict["code"] as? String { // Get authorization code
            do {
                try TraktManager.sharedManager.getTokenFromAuthorizationCode(code: code) { result in
                    switch result {
                    case .success:
                        print("Signed in to Trakt")
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .TraktSignedIn, object: nil)
                        }
                    case .failure(let err):
                        print("Failed to sign in to Trakt \(err)")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    private static func queryDict(url: URL) -> [String: Any] {
        var info: [String: Any] = [String: Any]()
        let queryString = url.absoluteString
        for parameter in queryString.components(separatedBy: "?"){
            let parts = parameter.components(separatedBy: "=")
            if parts.count > 1 {
                let key = parts[0].removingPercentEncoding
                let value = parts[1].removingPercentEncoding
                if key != nil && value != nil{
                    info[key!] = value
                }
            }
        }
      
        return info
    }
    
    
    
}
