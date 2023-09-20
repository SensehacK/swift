//
//  MissionControl.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation



struct MissionControl {
    
    
    static func initializeEnv() {
        initializeTraktTVConstants()
        
    }
    
    private init() { }
    
    private static func initializeTraktTVConstants() {
        TraktManager.sharedManager.set(clientID: TraktAPI.clientId,
                                       clientSecret: TraktAPI.clientSecret,
                                       redirectURI: TraktAPI.redirectURI)
        
    }
    
    
    
}
