//
//  Network.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
public enum NetworkError: Error {
    case requestBad
    case requestDataFailedNetworkError
    case invalidURL
    case requestBadDecoding
    case unknown
}


public extension HTTPURLResponse {
    
    /// Check for HTTP status code = 200 - successful
     func isResponseOK() -> Bool {
         return (200...299).contains(self.statusCode)
     }
}


public class AsyncNetwork {
    
    
    // Private properties
//    private var disposeBag = Set<AnyCancellable>()
    private init() { }
    
    /// Singleton
    /**
    Creates a singleton object of AsyncNetwork class in order to make network request using Apple's Reactive framework `Combine`
     request using Generic type T: Codable, decodes it using JSON Decoder and returns the Future Result Type with `Success<T> Failure<Error>`.
   
   ```
     AsyncNetwork.shared.fetchData(url: "https://dummyjson.com/quotes")
   ```
   */
    public static let shared = AsyncNetwork()
    
    
    /**
     Makes a network request using Combine framework with type T: Codable and returns `Future<Result<T:Decodable, Error>>`.
    
    This API handles making a network request, parsing of network response into JSON data as long as the model <T> conforms to Protocol `Decodable`.
     
     - Parameter url: URL
     - Parameter type: Type of Model conforming to Decodable. Helps swift generic inference
     - Returns: Future<T, Error>
     - Warning: Safely storing of the subscribes needs to be done via storing the sink return value in `AnyCancellable`.
     
    ```
     var cancellables = Set<AnyCancellable>()
     var quotes: Quotes = []
     
     AsyncNetwork.shared.fetchData(url: "https://dummyjson.com/quotes", type: Quotes.self)
        .sink { completion in
            switch completion {
                case .failure(let error):
                    print("Error")
                case .finished:
                    print("Finish")
            }
        }
        receiveValue: { [weak self] quotesData in
            self?.quotes = quotesData
        }
        .store(in &cancellables)
     }
    ```
    */
    public func fetchData<T: Decodable>(url: String, id: Int? = nil, type: T.Type) async throws -> T {
        var tempUrl: String
        
        // Check for extra ID parameter
        if let id = id {
            tempUrl = url + "\(id)"
        } else {
            tempUrl = url
        }
        print("Value of constructed URL: $$$$$ ", tempUrl)
        
        
        guard let url = URL(string: tempUrl) else {
            throw NetworkError.invalidURL
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.isResponseOK() else {
            throw NetworkError.requestBad
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.requestBadDecoding
        }
        
        return decodedData
    }
    
    
    /**
     Makes a network request using Combine framework with type T: Codable and returns `Future<Result<[T:Decodable], Error>>`.
    
    This API handles making a network request, parsing of network response into JSON data as long as the model <T> conforms to Protocol `Decodable`.
     
     - Parameter url: URL
     - Parameter type: Type of Model conforming to Decodable. Helps swift generic inference
     - Returns: Future<[T], Error>
     - Warning: Safely storing of the subscribes needs to be done via storing the sink return value in `AnyCancellable`.
     
    ```
     var cancellables = Set<AnyCancellable>()
     var quotes: [Quotes] = []
     
     AsyncNetwork.shared.fetchData(url: "https://dummyjson.com/quotes", type: Quotes.self)
        .sink { completion in
            switch completion {
                case .failure(let error):
                    print("Error")
                case .finished:
                    print("Finish")
            }
        }
        receiveValue: { [weak self] quotesData in
            self?.quotes = quotesData
        }
        .store(in &cancellables)
     }
    ```
    */
    public func fetchDataArray<T: Decodable>(url: String, id: Int? = nil, type: T.Type) async throws -> [T] {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.isResponseOK() else {
            throw NetworkError.requestBad
        }
        
        guard let decodedData = try? JSONDecoder().decode([T].self, from: data) else {
            throw NetworkError.requestBadDecoding
        }
        
        return decodedData
    }
    
    
}



enum JSONParseError: Error {
    case fileNotFound
    case dataInitialisation(error: Error)
    case decoding(error: Error)
}

extension Decodable {
    static func from(localJSON filename: String,
                     bundle: Bundle = .main) -> Result<Self, JSONParseError> {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            return .failure(.fileNotFound)
        }
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch let error {
            return .failure(.dataInitialisation(error: error))
        }

        do {
            return .success(try JSONDecoder().decode(self, from: data))
        } catch let error {
            return .failure(.decoding(error: error))
        }
    }
}
