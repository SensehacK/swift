//
//  AVPlayerExtension.swift
//  VideoStreamingKit
//
//  Created by Kautilya Save on 4/23/23.
//

import AVKit


extension AVPlayer {
   func stop(){
    
    self.seek(to: CMTime.zero)
    self.pause()
   }
}
