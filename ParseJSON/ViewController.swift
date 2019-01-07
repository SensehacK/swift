//
//  ViewController.swift
//  ParseJSON
//
//  Created by Kautilya on 07/01/19.
//  Copyright © 2019 Kautilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Launched Success")
        
        if let path = Bundle.main.path(forResource: "Trial", ofType: "json") {
            do {
                let data2 = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data2 , options: .mutableLeaves)
                if let jsonResult2 = jsonResult as? Dictionary<String, AnyObject>, let restaurant = jsonResult2["restaurant-info"] as? [Any] {
                    print(restaurant)
//                    let restType = restaurant["name"] as String
//                    let restTime = restaurant["avg_delivery_time"] as String
//                    let restDeliveryFee = restaurant["delivery-fee"] as String
                }
                
            } catch {
                // error
            }
        }
            
            
            if let path2 = Bundle.main.path(forResource: "tile", ofType: "json") {
                do {
                    let data2 = try Data(contentsOf: URL(fileURLWithPath: path2), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data2 , options: .mutableLeaves)
                    if let jsonResult2 = jsonResult as? Dictionary<String, AnyObject>, let restaurant = jsonResult2["person"] as? [Any] {
                        print(restaurant)
                    }
                    
                } catch {
                    // error
                }
            }
            
            if let path = Bundle.main.path(forResource: "Trial", ofType: "json") {
                do {
                    let data2 = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    if let jsonResult2 = try JSONSerialization.jsonObject(with: data2 , options: []) as? [String:Any] {
                        if let dataR = jsonResult2["restaurant-info"] as? [String:Any] {
                            if let dataRRS = dataR["name"] as? String {
                                print(dataRRS)
                            }
                            
                            if let dataRew = dataR["payment-methods"] as? [[String:Any]] {
                                for raw in dataRew {
                                    print("Sensehack")
                                    print(raw["id"] ?? 0)
                                    print(raw["type"] ?? "kaido")
                                }
                            }
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                } catch {
                    // error
                }
            }
            
            
            
            
            
            
        
    }
    

}

