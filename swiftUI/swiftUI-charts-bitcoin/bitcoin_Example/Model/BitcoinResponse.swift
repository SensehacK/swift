//
//  BitcoinResponse.swift
//  bitcoin_Example
//
//  Created by Kautilya Save on 5/5/23.
//

import Foundation
// MARK: - Bitcoin
struct Bitcoin: Codable {
    let name, symbol: String
    let priceLastTenHours: [Int]

    enum CodingKeys: String, CodingKey {
        case name, symbol
        case priceLastTenHours = "price_last_ten_hours"
    }
}
