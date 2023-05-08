//
//  NetworkManagerDelegate.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/8/23.
//

import Foundation

protocol NetworkManagerDelegate {
    func getData(completion: @escaping(Result<UsersConsumableViewModel, Error>) -> Void)
    
}
