//
//  Network.swift
//  webView
//
//  Created by Kautilya Save on 10/27/22.
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

struct WashingtonFetcher {
    
    enum WashingtonFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    static func generateEndpointNetwork(repoName: String, path: String, methodName: String,passId: MountainPassName) -> String {
        
        let urlCreated = "\(repoName)\(path)\(methodName)?\(AppConstants.accessCodeString.rawValue)\(AppConstants.accessCode.rawValue)&\(AppConstants.passConditionString.rawValue)=\(passId.rawValue)"
        print("####")
        print(urlCreated)
        return urlCreated
    }
    
    static func fetchWashington(apiMethod: MountainPassName,
                                completion: @escaping (Result<Washington, Error>) -> Void) {
        
        let endpoint = generateEndpointNetwork(repoName: AppConstants.baseURL.rawValue, path: AppConstants.pathName.rawValue, methodName: AppConstants.methodName.rawValue, passId: apiMethod)
        
        // Create URL
        guard let url = URL(string: endpoint ) else {
            completion(.failure(WashingtonFetcherError.invalidURL))
            return
        }
        
        // Create URL session data task
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(WashingtonFetcherError.missingData))
                return
            }
            
            do {
                // Parse the JSON data
                let apiResult = try JSONDecoder().decode(Washington.self, from: data)
                completion(.success(apiResult))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
