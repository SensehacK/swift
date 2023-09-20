//
//  TraktService.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftSense
import Foundation

protocol TraktService {
    
    func fetchTrakts() async -> TraktViewData?
//    func fetchTraktDetails(id: Int) async -> TraktDetailAPI?
}


class TraktDataFetcher: TraktService {
    
    static var shared: TraktDataFetcher = TraktDataFetcher()
    private init() { }
    
    func fetchTrakts2() async -> TraktViewData? {
        
        do {
            
            let data = try await AsyncNetwork.shared.fetchDataArray(url: URLConstants.traktMovieTestURL, type: TraktMovie.self)
            
            
            let traktViewData: TraktViewData = .init(movies: data, id: 0)
            
            return traktViewData
            
//            for (index, trakt) in data.enumerated() {
//                traktViewData.append(TraktViewData(Trakt: Trakt, id: index+1))
//            }
            
//            let data = try await NetworkManager.shared.fetchData(url: URLConstants.traktMovieTestURL)
//            
//            let decodedData = try JSONDecoder().decode(TraktAPI.self, from: data)
//            var TraktViewData: [TraktViewData] = []
//            for (index, Trakt) in decodedData.results.enumerated() {
//                TraktViewData.append(TraktViewData(Trakt: Trakt, id: index+1))
//            }
//
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
    
    
    func fetchTrakts() async -> TraktViewData? {
        do {
            let data = try await NetworkManager.shared.fetchData(url: URLConstants.traktMovieTestURL)
//            let data = try await NetworkManager.shared.fetchData2()
            
            let decodedData: TraktMovies = try JSONDecoder().decode(TraktMovies.self, from: data)
            
            let traktViewData: TraktViewData = .init(movies: decodedData, id: 0)
            
            return traktViewData

        } catch {
            print(error.localizedDescription)
        }
        
        return nil
        
        
        
    }
    
    
//    func fetchTraktDetails(id: Int) async -> TraktDetailAPI? {
//        
//        do {
//            let url = URLConstants.TraktBaseURL + String(id)
//            let data = try await NetworkManager.shared.fetchData(url: url)
//            let decodedData = try JSONDecoder().decode(TraktDetailAPI.self, from: data)
//            return decodedData
//        } catch {
//            print(error)
//            print(error.localizedDescription)
//        }
//
//        return nil
//    }
    
    
}



class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private init() { }
    
    
    
    func fetchData(url: String) async throws -> Data {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Connection", forHTTPHeaderField: "keep-alive")
//        
//        urlRequest.setValue("Content-Type", forHTTPHeaderField: "application/json")
//        urlRequest.setValue("trakt-api-version", forHTTPHeaderField: "2")
        
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.addValue("Connection", forHTTPHeaderField: "keep-alive")
        urlRequest.addValue("2" , forHTTPHeaderField: "trakt-api-version")
        urlRequest.addValue("Your_API_Key", forHTTPHeaderField: "trakt-api-key")
        
        

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode)
        else {
            print("Error here")
            throw URLError(.badServerResponse)
        }
        
        
        return data
    }
    
    
    func fetchData2(url: String = URLConstants.tMovieDBTestURL) async throws -> Data {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode)
        else {
            print("Error here")
            throw URLError(.badServerResponse)
        }
        
        
        return data
    }
    
}
