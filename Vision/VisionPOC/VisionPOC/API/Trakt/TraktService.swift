//
//  TraktService.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/19/23.
//

import SwiftSense
import UIKit

protocol TraktService {
    
    func fetchTrakts() async -> TraktViewData?
    func fetchAllRecentMoviesDetailsWithImagesAsync(movies: [TraktMovie]) async throws -> [Int: TraktConsumableView]?
//    func fetchSingleMovieDetailView(movie: TraktMovie, tmdbMovieID: Int) async throws -> TraktConsumableView
    func fetchSingleMovieDetails(id: Int) async -> TMDBMovieAPI?
}


class TraktDataFetcher: TraktService {
    
    static var shared: TraktDataFetcher = TraktDataFetcher()
    private init() { }
    
    func fetchTrakts2() async -> TraktViewData? {
        
        do {
            
            let data = try await AsyncNetwork.shared.fetchDataArray(url: URLConstants.traktMovieTestURL, type: TraktMovie.self)
            
            let traktViewData: TraktViewData = .init(movies: data, id: 0)
            
            return traktViewData
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
    
    
    func fetchTrakts() async -> TraktViewData? {
        do {
            
            guard let url = URL(string: URLConstants.traktMovieTestURL) else {
                throw URLError(.badURL)
            }
            
            // Manifest the URL Request with appropriate HEaders
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("2" , forHTTPHeaderField: "trakt-api-version")
            urlRequest.addValue(APIKeys.trakt, forHTTPHeaderField: "trakt-api-key")
            
//            let data = try await NetworkManager.shared.fetchData(url: URLConstants.traktMovieTestURL)
            
            let data = try await NetworkManager.shared.fetchData(urlRequest: urlRequest)
            
            let decodedData: TraktMovies = try JSONDecoder().decode(TraktMovies.self, from: data)
            
            let traktViewData: TraktViewData = .init(movies: decodedData, id: 0)
            
            return traktViewData

        } catch {
            print(error.localizedDescription)
        }
        
        return nil
        
        
        
    }
    
    
    
    
    func fetchAllRecentMoviesDetailsWithImagesAsync(movies: [TraktMovie]) async throws -> [Int: TraktConsumableView]? {
            // run your Async work
            let traktViewAsync = try? await self.fetchTraktAsyncTaskGroup(movies: movies)

            return traktViewAsync
        
    }
    
    
    func fetchSingleMovieDetails(id: Int) async -> TMDBMovieAPI? {
        
        do {
            let url = URLConstants.movieBaseURL + String(id) + URLConstants.tmdbAPIKeyParam
            let data = try await NetworkManager.shared.fetchData(url: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(TMDBMovieAPI.self, from: data)
            return decodedData
        } catch {
            print(error)
            print(error.localizedDescription)
        }

        return nil
    }
    
    
}


// MARK: - Fetching TraktMovie Details with Image Concurrently - Async
extension TraktDataFetcher {
    
    private func fetchTraktAsyncTaskGroup(movies: [TraktMovie]) async throws -> [Int: TraktConsumableView] {
        return try await withThrowingTaskGroup(of: TraktConsumableView?.self) { [weak self] group in
            guard let self = self else { throw URLError(.backgroundSessionInUseByAnotherProcess) }
            var movieDict: [Int: TraktConsumableView] = [:]
//            movieDict.reserveCapacity(15)

            for movie in movies {
                group.addTask {
                    try await self.fetchSingleMovieDetailView(movie: movie, tmdbMovieID: movie.movie.ids.tmdb)
                }
            }

            
            // Resolve it using Dictionary Approach
            for try await image in group {
                if let image = image {
                    let index = image.id
//                    print("Inserting at Index: \(index)")
                    movieDict[index] = image

                }
            }
            print("Done fetching All trakt Async Concurrently")
            return movieDict
        }
    }

    private func fetchSingleMovieDetailView(movie: TraktMovie, tmdbMovieID: Int) async throws -> TraktConsumableView {
        
        guard let movieDetail = await fetchSingleMovieDetails(id: tmdbMovieID) else {
            print("Error fetching poke detail")
            throw URLError(.badURL)
        }

        
        let moviePosterURL = URLConstants.movieImageBaseURL + Resolution.Poster.w500.rawValue + movieDetail.posterPath
        let movieBackgroundURL = URLConstants.movieImageBaseURL + Resolution.Background.w1280.rawValue + movieDetail.backdropPath
        
        print("Movie Posters")
        
        guard let posterURL = URL(string: moviePosterURL) else { throw URLError(.badURL) }
        let (posterImgData, _) = try await URLSession.shared.data(from: posterURL)
        guard let posterImage = UIImage(data: posterImgData) else { throw URLError(.badURL) }
        
        
        guard let backgroundURL = URL(string: movieBackgroundURL) else { throw URLError(.badURL) }
        let (backgroundImgData, _) = try await URLSession.shared.data(from: backgroundURL)
        guard let backgroundImage = UIImage(data: backgroundImgData) else { throw URLError(.badURL) }
        
        
        let defaultImage: UIImage = UIImage(systemName: "globe")!

        let movieDetailView = TraktConsumableView(id: movie.id,
                                                  movieDetails: movie,
                                                  posterImage: posterImage,
                                                  backgroundImage: backgroundImage,
                                                  trailerImage: movieDetail.homepage)
        return movieDetailView
    }
    
    
    
    
}



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
            print("Error here")
            throw URLError(.badServerResponse)
        }

        return data
    }
    
    
    func fetchData(urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
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
