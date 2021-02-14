//
//  ImageViewModel.swift
//  ImageViewJSON
//
//  Created by Sensehack on 2/13/21.
//

import Foundation
import UIKit


struct Response: Codable {
    let manifest: [[String]]
}


struct ImageResponse: Codable {
    let name: String
    let url: String
    let type: String
    let width: Int
    let height: Int
}
