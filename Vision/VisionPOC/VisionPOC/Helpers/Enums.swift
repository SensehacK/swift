//
//  Enums.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation

public enum Method: String {
    /// Select one or more items. Success returns 200 status code.
    case GET
    /// Create a new item. Success returns 201 status code.
    case POST
    /// Update an item. Success returns 200 status code.
    case PUT
    /// Delete an item. Success returns 200 or 204 status code.
    case DELETE
}

public struct StatusCodes {
    /// Success
    public static let Success = 200
    /// Success - new resource created (POST)
    public static let SuccessNewResourceCreated = 201
    /// Success - no content to return (DELETE)
    public static let SuccessNoContentToReturn = 204
    /// Bad Request - request couldn't be parsed
    public static let BadRequest = 400
    /// Unauthorized - OAuth must be provided
    public static let Unauthorized = 401
    /// Forbidden - invalid API key or unapproved app
    public static let Forbidden = 403
    /// Not Found - method exists, but no record found
    public static let NotFound = 404
    /// Method Not Found - method doesn't exist
    public static let MethodNotFound = 405
    /// Conflict - resource already created
    public static let Conflict = 409
    /// Precondition Failed - use application/json content type
    public static let PreconditionFailed = 412
    /// Account Limit Exceeded - list count, item count, etc
    public static let AccountLimitExceeded = 420
    /// Unprocessable Entity - validation errors
    public static let UnprocessableEntity = 422
    /// Trakt account locked. Have user contact Trakt https://github.com/trakt/api-help/issues/228
    public static let acountLocked = 423
    /// VIP Only - user must upgrade to VIP
    public static let vipOnly = 426
    /// Rate Limit Exceeded
    public static let RateLimitExceeded = 429
    /// Server Error
    public static let ServerError = 500
    /// Service Unavailable - Cloudflare error
    public static let CloudflareError = 520
    /// Service Unavailable - Cloudflare error
    public static let CloudflareError2 = 521
    /// Service Unavailable - Cloudflare error
    public static let CloudflareError3 = 522

    static func message(for status: Int) -> String? {
        switch status {
        case Unauthorized:
            return "App not authorized. Please sign in again."
        case Forbidden:
            return "Invalid API Key"
        case NotFound:
            return "API not found"
        case AccountLimitExceeded:
            return "The number of Trakt lists or list items has been exceeded. Please see Trakt.tv for account limits and support."
        case acountLocked:
            return "Trakt.tv has indicated that this account is locked. Please contact Trakt support to unlock your account."
        case vipOnly:
            return "This feature is VIP only with Trakt. Please see Trakt.tv for more information."
        case RateLimitExceeded:
            return "Rate Limit Exceeded. Please try again in a minute."
        case ServerError..<CloudflareError:
            return "Trakt.tv is down. Please try again later."
        case CloudflareError..<600:
            return "CloudFlare error. Please try again later."
        default:
            return nil
        }
    }
}
