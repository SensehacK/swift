//
//  UsersViewModel.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import Foundation
import SwiftSense
import Combine

@MainActor
class UsersViewModel: ObservableObject {
    
    @Published var users: UsersConsumableViewModel?
    
    // Private
    var anyCancellables = Set<AnyCancellable>()
    
    
    func fetchUsers() {
        let url: String = "https://dummyjson.com/users"
        
        CombineNetwork
            .shared
            .fetchData(url: url, type: UsersAPI.self)
            .sink { completion in
                print("Completion")
            } receiveValue: { [weak self] data in
                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
                
                self?.users = UsersConsumableViewModel(usersData: userArray)
            }
            .store(in: &anyCancellables)
    }
    
    
}





