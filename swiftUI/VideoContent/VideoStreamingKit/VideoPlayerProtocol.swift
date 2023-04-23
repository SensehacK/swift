//
//  VideoPlayerProtocol.swift
//  VideoStreamingKit
//
//  Created by Kautilya Save on 4/22/23.
//

import UIKit

public protocol VideoPlayerProtocol {
    
    func addVideo(view: UIView)
    
    func pauseVideo()
    
    func playVideo()
    
    func configureVideo(url: URL)

}


public enum PlayerState: Int {
    case isLoading = 0
    case isPlaying = 1
    case isPaused = 2
    case isStopped = 3
    case isNotLoading = 4
    case isVideoAvailable = 5
    case isVideoUnAvailable = 6
    
    public func description() -> String {
        var result = ""
        switch self {
        case .isLoading:
            print("Hello is Loading")
            result = "isLoading"
        case .isPlaying:
            result = "isPlaying"
        case .isPaused:
            result = "isPaused"
        case .isStopped:
            result = "isStopped"
        case .isNotLoading:
            result = "isNotLoading"
        case .isVideoAvailable:
            result = "isVideoAvailable"
        
        case .isVideoUnAvailable:
            result = "isVideoUnAvailable"
        
        }
   
        
        return result
    }
}



