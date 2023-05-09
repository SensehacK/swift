//
//  UsersConsumableViewModel.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import Foundation

// Actual Consumable UI Model
struct UsersConsumableViewModel {
    
    private let usersData: [UserConsumableViewModel]
    
    init(usersData: [UserConsumableViewModel]) {
        self.usersData = usersData
    }
    
    var users: [UserConsumableViewModel] {
        usersData
    }
    
    var firstUser: UserConsumableViewModel? {
        usersData.first
    }
}

struct UserConsumableViewModel: Identifiable {
    let id: Int
    let name: String
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

// JSON Placeholder API
struct JsonPlaceholderUserConsumableViewModel: Identifiable {
    private let userData: UsersAPIElement
    let id: Int
    
    init(userData: UsersAPIElement) {
        self.userData = userData
        self.id = userData.id
    }

    
    var name: String {
        userData.name
    }
    
}

// Dummy JSON API
struct DUserConsumableViewModel: Identifiable {
    private let user: User
    let id: Int
    
    init(user: User) {
        self.user = user
        self.id = user.id
    }

    
    var name: String {
        user.firstName + "-" + user.lastName
    }
    
}



