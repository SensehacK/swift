//
//  NetworkManager.swift
//  Pokemon-App
//
//  Created by Kautilya Save on 5/11/23.
//

import Foundation


class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private init() { }
    
    
    
    func fetchData(url: String) async throws -> Data {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode)
        else {
            throw URLError(.badURL)
        }
        
        
        return data
    }
    
    
}
