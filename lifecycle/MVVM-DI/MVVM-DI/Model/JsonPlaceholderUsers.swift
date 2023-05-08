//
//  JsonPlaceholderUsers.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/8/23.
//

import Foundation

// MARK: - UsersAPIElement
struct UsersAPIElement: Codable {
    let id: Int
    let name, username, email: String
    let address: JUsersAddress
    let phone, website: String
    let company: JUsersCompany
}

// MARK: - Address
struct JUsersAddress: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct JUsersCompany: Codable {
    let name, catchPhrase, bs: String
}

typealias UsersJSONAPI = [UsersAPIElement]
