//
//  NetworkManager.swift
//  bitcoin_Example
//
//  Created by Kautilya Save on 5/5/23.
//

import Foundation
import Combine

class NetworkManager {
    
    
    var cancellables = Set<AnyCancellable>()
    
    static var shared = NetworkManager()
    
    private init() { }
    
    
//    func fetchData<T: Decodable>(url: String) -> Future<T, NetworkError> {
//        return Future<T, Error>  { promise in
//
//
//            guard let url = URL(string: url) else {
//                return NetworkError.requestBadURL
//            }
//
//
//            URLSession.shared.dataTaskPublisher(for: url)
//                .tryMap { data, response -> Data in
//                    <#code#>
//                }
//
//
//
//        }
//
//    }
    
    
    func fetchData<T: Decodable>(url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw NetworkError.requestBadURL
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.badDecoding
        }
        
        return decodedData
    }
}


enum NetworkError: Error {
    
    case requestBadURL
    case badDecoding
    
}




