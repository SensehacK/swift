//
//  AuthenticationInfo.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation

public struct AuthenticationInfo: Decodable, Hashable {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: TimeInterval
    public let refreshToken: String
    public let scope: String
    public let createdAt: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case createdAt = "created_at"
    }
}
