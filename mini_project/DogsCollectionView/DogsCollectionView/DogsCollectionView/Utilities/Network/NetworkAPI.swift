//
//  NetworkAPI.swift
//  DogsCollectionView
//
//  Created by Sensehack on 3/26/21.
//

import Foundation

class NetworkAPI {
    
    
    // MARK: Shared Instance
    class func sharedInstance() -> NetworkAPI {
        struct Singleton {
            static var sharedInstance = NetworkAPI()
        }
        return Singleton.sharedInstance
    }
    
    typealias Handler<Flickr> = (Result<Flickr, Error>) -> Void
    
    func getImagesByFlickr(tagName: String, format: String, completionHandler: @escaping Handler<Flickr>) {
        
        guard let url = URL(string: AppConstants.baseURL + AppConstants.tags + tagName + AppConstants.format + format + AppConstants.noCallback
        ) else { return }
        
        print("the current URL: " + url.absoluteString)
        // Creating URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return completionHandler(.failure(error!)) }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Flickr.self, from: data)
//                print(response)
                completionHandler(.success(response))
            } catch let error {
                print("Error in retrieving data" + error.localizedDescription)
            }
        }

        // Resume Asynchronous network call
        task.resume()
        
        
    }
}
