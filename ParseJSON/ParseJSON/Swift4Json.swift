//
//  Swift4Json.swift
//  ParseJSON
//
//  Created by Kautilya on 09/01/19.
//  Copyright © 2019 Kautilya. All rights reserved.
//

import Foundation

struct User: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}




class SwiftJson {
    
    
    
    func swiftJ() {
        
        guard let urlPH = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        let task = URLSession.shared.dataTask(with: urlPH) { (data, response ,error) in
            
            guard let dataResponse = data , error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                print("Error in response")
                return
            }
            
            do {
                // Data response handling
                let decoder = JSONDecoder()
                let model = try decoder.decode([User].self, from: dataResponse) // decode response data
                print("Swift JSON class")
                print(model)
            } catch {
                print("error")
            }
            
            
         
            
            
        }
        task.resume()
        
        
    }
    
    
}
