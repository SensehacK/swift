//
//  NetworkManager.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import Foundation


class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private init() { }
    
    
    func fetchData<T:Codable>(url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Error casting response")
            throw URLError(.badURL)
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            print("Error in Response Code")
            throw URLError(.badURL)
        }
        
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        return decodedData
    }
    
}
