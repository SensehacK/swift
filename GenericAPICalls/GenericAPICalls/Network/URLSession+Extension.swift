//
//  URLSession+Extension.swift
//  GenericAPICalls
//
//  Created by Kautilya Save on 4/11/23.
//

import Foundation
// Extension for URL Session for Generic URLSession
extension URLSession {
    
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    
    func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        // Handle URL unfurling
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let task = dataTask(with: url) { data, _, error in
            
            
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
            
            
        }
        task.resume()
    }
}

