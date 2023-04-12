//
//  WeatherInfo.swift
//  SwiftUI-Weather
//
//  Created by Kautilya Save on 4/12/23.
//

import Foundation

struct WeatherInfo: Identifiable {
    var id: Int
    let day: day
    let weatherIcon: String
    let temp: Int
}

enum day: String {
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat

    var value: String {
        self.rawValue.uppercased()
    }
}
