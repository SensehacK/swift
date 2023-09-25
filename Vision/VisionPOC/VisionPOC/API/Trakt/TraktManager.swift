//
//  TraktManager.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import Foundation

public extension Notification.Name {
    static let TraktAccountStatusDidChange = Notification.Name(rawValue: "signedInToTrakt")
    
    static let TraktSignedIn = Notification.Name(rawValue: "TraktSignedIn")
    
}


public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func _dataTask(with request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

public protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

// MARK: Conform to protocols

extension URLSession: URLSessionProtocol {
    public func _dataTask(with request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completion) as URLSessionDataTaskProtocol
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}



public class TraktManager {
    
    
    // MARK: - Properties
    
    private enum Constants {
        static let tokenExpirationDefaultsKey = "accessTokenExpirationDate"
        static let oneMonth: TimeInterval = 2629800
    }
    
    public enum SuccessResultType {
        case success
        case fail
    }
    public typealias SuccessCompletionHandler = (_ result: SuccessResultType) -> Void
    
    // MARK: Internal
    private var staging: Bool?
    private var clientID: String?
    private var clientSecret: String?
    private var redirectURI: String?
    private var baseURL: String?
    private var APIBaseURL: String?
    private var isWaitingToToken: Bool = false
    let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    // Keys
    let accessTokenKey = "accessToken"
    let refreshTokenKey = "refreshToken"
    
    let session: URLSessionProtocol
    
    
    
    // MARK: Public
    public static let sharedManager = TraktManager()
    
    public var isSignedIn: Bool {
        get {
            return accessToken != nil
        }
    }
    public var oauthURL: URL?
    
    private var _accessToken: String?
    public var accessToken: String? {
        get {
            if _accessToken != nil {
                return _accessToken
            }
            if let accessTokenData = SKeychain.loadData(forKey: accessTokenKey) {
                if let accessTokenString = String(data: accessTokenData, encoding: .utf8) {
                    _accessToken = accessTokenString
                    return accessTokenString
                }
            }
            
            return nil
        }
        set {
            // Save somewhere secure
            _accessToken = newValue
            if newValue == nil {
                // Remove from keychain
                SKeychain.deleteItem(forKey: accessTokenKey)
            } else {
                // Save to keychain
                let succeeded = SKeychain.setString(value: newValue!, forKey: accessTokenKey)
                #if DEBUG
                print("Saved access token: \(succeeded)")
                #endif
            }
        }
    }
    
    private var _refreshToken: String?
    public var refreshToken: String? {
        get {
            if _refreshToken != nil {
                return _refreshToken
            }
            if let refreshTokenData = SKeychain.loadData(forKey: refreshTokenKey) {
                if let refreshTokenString = String.init(data: refreshTokenData, encoding: .utf8) {
                    _refreshToken = refreshTokenString
                    return refreshTokenString
                }
            }
            
            return nil
        }
        set {
            // Save somewhere secure
            _refreshToken = newValue
            if newValue == nil {
                // Remove from keychain
                SKeychain.deleteItem(forKey: refreshTokenKey)
            } else {
                // Save to keychain
                let succeeded = SKeychain.setString(value: newValue!, forKey: refreshTokenKey)
                #if DEBUG
                print("Saved refresh token: \(succeeded)")
                #endif
            }
        }
    }
    
    // MARK: - Lifecycle
    
//    public init() {
//        
//    }
    
    public init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Setup
    
    public func set(clientID: String, clientSecret secret: String, redirectURI: String, staging: Bool = false) {
        self.clientID = clientID
        self.clientSecret = secret
        self.redirectURI = redirectURI
        self.staging = staging
        
        self.baseURL = !staging ? "trakt.tv" : "staging.trakt.tv"
        self.APIBaseURL = !staging ? "api.trakt.tv" : "api-staging.trakt.tv"
        self.oauthURL = URL(string: "https://\(baseURL!)/oauth/authorize?response_type=code&client_id=\(clientID)&redirect_uri=\(redirectURI)")
    }
    
    ///*
    internal func createErrorWithStatusCode(_ statusCode: Int) -> NSError {
        let message: String
        
        if let traktMessage = StatusCodes.message(for: statusCode) {
            message = traktMessage
        } else {
            message = "Request Failed: Gateway timed out (\(statusCode))"
        }
        
        let userInfo = [
            "title": "Error",
            NSLocalizedDescriptionKey: message,
            NSLocalizedFailureReasonErrorKey: "",
            NSLocalizedRecoverySuggestionErrorKey: ""
        ]
        let TraktKitIncorrectStatusError = NSError(domain: "com.litteral.TraktKit", code: statusCode, userInfo: userInfo)
        
        return TraktKitIncorrectStatusError
    }
    
    // MARK: - Actions
    
    public func signOut() {
        accessToken = nil
        refreshToken = nil
        UserDefaults.standard.removeObject(forKey: Constants.tokenExpirationDefaultsKey)
    }
    
    internal func mutableRequestForURL(_ url: URL?, authorization: Bool, HTTPMethod: Method) -> URLRequest? {
        guard
            let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        if let clientID = clientID {
            request.addValue(clientID, forHTTPHeaderField: "trakt-api-key")
        }
        
        if authorization {
            if let accessToken = accessToken {
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            else {
                return nil
            }
        }
        
        return request
    }
    
    internal func mutableRequest(forPath path: String, withQuery query: [String: String], isAuthorized authorized: Bool, withHTTPMethod httpMethod: Method) -> URLRequest? {
        guard let apiBaseURL = APIBaseURL else { preconditionFailure("Call `set(clientID:clientSecret:redirectURI:staging:)` before making any API requests") }
        let urlString = "https://\(apiBaseURL)/" + path
        guard var components = URLComponents(string: urlString) else { return nil }
        
        if query.isEmpty == false {
            var queryItems: [URLQueryItem] = []
            for (key, value) in query {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            components.queryItems = queryItems
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        if let clientID = clientID {
            request.addValue(clientID, forHTTPHeaderField: "trakt-api-key")
        }
        
        if authorized {
            if let accessToken = accessToken {
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        }
        
        return request
    }
    
    func post<Body: Encodable>(_ path: String, query: [String: String] = [:], body: Body) -> URLRequest? {
        guard let apiBaseURL = APIBaseURL else { preconditionFailure("Call `set(clientID:clientSecret:redirectURI:staging:)` before making any API requests") }
        let urlString = "https://\(apiBaseURL)/" + path
        guard var components = URLComponents(string: urlString) else { return nil }
        if query.isEmpty == false {
            var queryItems: [URLQueryItem] = []
            for (key, value) in query {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            components.queryItems = queryItems
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        if let clientID = clientID {
            request.addValue(clientID, forHTTPHeaderField: "trakt-api-key")
        }
        
        if let accessToken = accessToken {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            request.httpBody = try jsonEncoder.encode(body)
        } catch {
            return nil
        }
        return request
    }
    
    // MARK: - Authentication
    
    public func getTokenFromAuthorizationCode(code: String, completionHandler: @escaping (Result<String, Error>) -> Void) throws {
        guard
            let clientID = clientID,
            let clientSecret = clientSecret,
            let redirectURI = redirectURI
        else {
            
            completionHandler(.failure(URLError.cancelled))
            return
        }
        
        let urlString = "https://\(baseURL!)/oauth/token"
        let url = URL(string: urlString)
        guard var request = mutableRequestForURL(url, authorization: false, HTTPMethod: .POST) else {
            completionHandler(.failure(URLError.cancelled))
            return
        }
        
        let json = [
            "code": code,
            "client_id": clientID,
            "client_secret": clientSecret,
            "redirect_uri": redirectURI,
            "grant_type": "authorization_code",
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        
        session._dataTask(with: request) { [weak self] data, response, error in
            guard
                let welf = self else { return }
            guard error == nil else {
                completionHandler(.failure(URLError.cancelled))
                return
            }
            
            // Check response
            guard
                let HTTPResponse = response as? HTTPURLResponse,
                HTTPResponse.statusCode == StatusCodes.Success else {
                completionHandler(.failure(URLError.cancelled))
                return
            }
            
            // Check data
            guard
                let data = data else {
                completionHandler(.failure(URLError.cancelled))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let authenticationInfo = try decoder.decode(AuthenticationInfo.self, from: data)
                #if DEBUG
                print(authenticationInfo)
                print("[\(#function)] Access token is \(String(describing: welf.accessToken))")
                print("[\(#function)] Refresh token is \(String(describing: welf.refreshToken))")
                #endif
                
                welf.accessToken = authenticationInfo.accessToken
                welf.refreshToken = authenticationInfo.refreshToken
                // Save expiration date
                let expiresDate = Date(timeIntervalSinceNow: authenticationInfo.expiresIn)
                UserDefaults.standard.set(expiresDate, forKey: Constants.tokenExpirationDefaultsKey)
                
                // Post notification
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .TraktAccountStatusDidChange, object: nil)
                }
                
                completionHandler(.success(authenticationInfo.accessToken))
            } catch {
                completionHandler(.failure(URLError.cancelled))
            }
        }.resume()
    }
    
//     */
}

// To not have to insert as? Error everytime
extension URLError.Code : Error {
    
}
