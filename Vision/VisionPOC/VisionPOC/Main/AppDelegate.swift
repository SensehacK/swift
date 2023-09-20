//
//  AppDelegate.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation
import UIKit


class VSPAppDelegate: NSObject, UIApplicationDelegate {
  
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      print("I'm in App Delegate")
      
      MissionControl.initializeEnv()
      
      //
      
    return true
  }
    
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print("Hello - Did I get a callback here!")
        // Parse the URL callback from Trakt API Oauth
        TokenCapture.parseURLSchemeToExtractToken(url: url)
        
        return true
    }
    
//    func application(_ application: UIApplication,
//                     open url: URL,
//                     options: [UIApplicationOpenURLOptionsKey : Any] = [:] ) -> Bool {
//        
//    }
    
}
