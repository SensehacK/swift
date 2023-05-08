//
//  Users.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import Foundation

// Dummy JSON https://dummyjson.com/users
// MARK: - UsersAPI
struct DUsersAPI: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender: Gender
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int
    let weight: Double
    let eyeColor: EyeColor
    let hair: Hair
    let domain, ip: String
    let address: Address
    let macAddress, university: String
    let bank: Bank
    let company: Company
    let ein, ssn, userAgent: String
}

// MARK: - Address
struct Address: Codable {
    let address: String
    let city: String?
    let coordinates: Coordinates
    let postalCode, state: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat, lng: Double
}

// MARK: - Bank
struct Bank: Codable {
    let cardExpire, cardNumber, cardType, currency: String
    let iban: String
}

// MARK: - Company
struct Company: Codable {
    let address: Address
    let department, name, title: String
}

enum EyeColor: String, Codable {
    case amber = "Amber"
    case blue = "Blue"
    case brown = "Brown"
    case gray = "Gray"
    case green = "Green"
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - Hair
struct Hair: Codable {
    let color: Color
    let type: TypeEnum
}

enum Color: String, Codable {
    case auburn = "Auburn"
    case black = "Black"
    case blond = "Blond"
    case brown = "Brown"
    case chestnut = "Chestnut"
}

enum TypeEnum: String, Codable {
    case curly = "Curly"
    case straight = "Straight"
    case strands = "Strands"
    case veryCurly = "Very curly"
    case wavy = "Wavy"
}
