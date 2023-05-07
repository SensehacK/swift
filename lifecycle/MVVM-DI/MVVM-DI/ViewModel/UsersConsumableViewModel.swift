//
//  UsersConsumableViewModel.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import Foundation


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
    private let userData: User
    let id: Int
    
    init(userData: User) {
        self.userData = userData
        self.id = userData.id
    }

    
    var name: String {
        userData.firstName + "-" + userData.lastName
    }
    
}
