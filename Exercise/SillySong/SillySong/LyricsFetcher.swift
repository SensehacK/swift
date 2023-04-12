//
//  LyricsFetcher.swift
//  SillySong
//
//  Created by Kautilya on 30/03/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import Foundation

func shortNameFromName( name : String ) -> String {
    
    var subString2 = ""
    let charSet = CharacterSet(charactersIn: "aeiou")
    
    if let index = name.lowercased().rangeOfCharacter(from: charSet)?.lowerBound {
        subString2 =  name.substring(from: index)
//        print(subString2)
    }
    else {
        subString2 = name
    }
    return subString2.lowercased()
}


let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    let short_name = shortNameFromName(name: fullName)
    
    let new_lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)

    let newer_lyrics = new_lyrics.replacingOccurrences(of: "<SHORT_NAME>", with: short_name)
    
//    print(newer_lyrics)
    
    return newer_lyrics
}
