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
    let networkManager = NetworkManager()
    
    
    func fetchUsers() {
        networkManager.getDataUsingCombineLibSubscription()
//        networkManager.getDataUsingAsyncAwait()
        
        networkManager
            .$userData
            .sink { completion in
                print("Completion")
            } receiveValue: { [weak self] data in
                print("Got userData ???")
                DispatchQueue.main.async {
                    self?.users = data
                }


            }
            .store(in: &anyCancellables)
    }
    
    func fetchUsers3() {
        print("Getting data3")
        networkManager.getData2()
        networkManager
            .users
            .sink { completion in
                print("Completion")
            } receiveValue: { [weak self] data in
                print("Got users Data???")
                self?.users = data
            }
            .store(in: &anyCancellables)
        
    }

}





