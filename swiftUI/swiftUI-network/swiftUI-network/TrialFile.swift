//
//  TrialFile.swift
//  swiftUI-network
//
//  Created by Kautilya Save on 4/15/23.
//


import Foundation
import Combine

public enum NetworkError: Error {
    case requestBad
    case requestDataFailedNetworkError
    case invalidURL
    case requestBadDecoding
    case unknown
}

@available(iOS 13.0, *)
public class AsyncNetwork {
    
    
    // Private properties
    private var disposeBag = Set<AnyCancellable>()
    private init() { }
    
    /// Singleton
    /**
    Creates a singleton object of AsyncNetwork class in order to make network request using Apple's Reactive framework `Combine`
     request using Generic type T: Codable and returns the two completioner handlers - Parsing & Result Type.
   
   ```
     AsyncNetwork.shared.getData(url: "https://dummyjson.com/quotes")
   ```
   */
    public static let shared = AsyncNetwork()
    
    
    /**
     Makes a network request using Combine framework with type T: Codable and returns `Future<Result<[T:Decodable], Error>>`.
    
    This API handles making a network request, parsing of network response into JSON data as long as the model <T> conforms to Protocol `Decodable`.
     
     - Parameter url: URL
     - Parameter type: Type of Model conforming to Decodable. Helps swift generic inference
     - Returns: Future<[T], Error>
     - Warning: Safely storing of the subscribes needs to be done via storing the sink return value in `AnyCancellable`.
     
    ```
     var cancellables = Set<AnyCancellable>()
     var quotes: Quotes = []
     
     AsyncNetwork.shared.getData(url: "https://dummyjson.com/quotes", type: Quotes.self)
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
    public func getData<T: Decodable>(url: String, id: Int? = nil, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            
            guard let self = self,
                  let url = URL(string: url) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("Hello!!!!")
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response -> Data in
                    guard let response = response as? HTTPURLResponse,
                          response.isResponseOK() else {
                        throw NetworkError.requestBad
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        print("Error")
                        switch error {
                            
                        case let decodingError as DecodingError:
                            print("Decoding")
                            print(decodingError)
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            print("API")
                            promise(.failure(apiError))
                        default:
                            print(":Unkonw")
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                } receiveValue: { value in
                    print("Success")
                    print(value)
                    promise(.success(value))
                }
                .store(in: &self.disposeBag)
        }
    }
    
    
}
