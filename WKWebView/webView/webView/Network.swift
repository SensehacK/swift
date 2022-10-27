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

class Network {
    
    var washingtonAPI: Washington?

    func generateEndpointNetwork(repoName: String, path: String, methodName: String,passId: MountainPassName) -> String {
//        "http://wsdot.wa.gov/Traffic/api/MountainPassConditions/MountainPassConditionsREST.svc/GetMountainPassConditionAsJon?AccessCode=d6701759-bf55-49e3-a2a7-dac879575026&PassConditionID=10"
//
        
        let urlCreated = "\(repoName)\(path)?\(AppConstants.accessCodeString.rawValue)\(AppConstants.accessCode.rawValue)&\(methodName)=\(passId)"
        
        return urlCreated
    }
    
}



struct WashingtonFetcher {
    
    enum WashingtonFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    static func generateEndpointNetwork(repoName: String, path: String, methodName: String,passId: MountainPassName) -> String {
        
        let urlCreated = "\(repoName)\(path)?\(AppConstants.accessCodeString.rawValue)\(AppConstants.accessCode.rawValue)&\(methodName)=\(passId)"
//        return "http://wsdot.wa.gov/Traffic/api/MountainPassConditions/MountainPassConditionsREST.svc/GetMountainPassConditionAsJon?AccessCode=d6701759-bf55-49e3-a2a7-dac879575026&PassConditionID=10"
        return urlCreated
    }
    
    static func fetchWashington(apiMethod: MountainPassName, completion: @escaping (Result<Washington, Error>) -> Void) {
        
        
//        let endpoint = "http://wsdot.wa.gov/Traffic/api/MountainPassConditions/MountainPassConditionsREST.svc/GetMountainPassConditionAsJon?AccessCode=d6701759-bf55-49e3-a2a7-dac879575026&PassConditionID=10"
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
