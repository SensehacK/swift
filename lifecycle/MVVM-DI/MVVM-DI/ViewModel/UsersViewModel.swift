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
    let networkService: NetworkManagerDelegate
    
    
    init(networkService: NetworkManagerDelegate = Bool.random() ? DummyJsonUserService() : JSONPlaceholderUserService()) {
        self.networkService = networkService
    }
    
    func fetchData() {
        fetchRandomUsers()
//        if Bool.random() {
//            fetchDummyUsers()
//        } else {
//            fetchJSONPUsers()
//        }
    }
    
    func fetchUsers() {
//        networkManager.getDataUsingCombineLibWithPublisherSubscription()
//        networkManager.getDataUsingAsyncAwait()
        
//        networkManager
//            .$userData
//            .sink { completion in
//                print("Completion")
//            } receiveValue: { [weak self] data in
//                print("Got userData ???")
//                DispatchQueue.main.async {
//                    self?.users = data
//                }
//
//
//            }
//            .store(in: &anyCancellables)
    }
    
    func fetchUsersUsingSubjectPublisher() {
        print("Getting data3")
//        networkManager.getDataUsingCombineWithSubjectPublisher()
//        networkManager
//            .users
//            .sink { completion in
//                print("Completion")
//            } receiveValue: { [weak self] data in
//                print("Got users Data???")
//                self?.users = data
//            }
//            .store(in: &anyCancellables)
        
    }
    
    func fetchUsersCallbacks() {
//        print("Getting data3")
//        networkManager.getData { [weak self] result in
//            switch result {
//            case .success(let model):
//                self?.users = model
//            case .failure(let error):
//                print("Error occured !!! : \(error.localizedDescription)")
//            }
//        }

    }
    
    @MainActor func fetchRandomUsers() {
        
        networkService
            .getData { [weak self] result in
            switch result {
            case .success(let model):
                self?.users = model
            case .failure(let error):
                print("Error occured !!! : \(error.localizedDescription)")
            }
        }
    }
    
    
    func fetchDummyUsers() {
        networkService.getData { [weak self] result in
            switch result {
            case .success(let model):
                self?.users = model
            case .failure(let error):
                print("Error occured !!! : \(error.localizedDescription)")
            }
        }
    }
    
    
    @MainActor func fetchJSONPUsers() {
        
        networkService.getData { [weak self] result in
            switch result {
            case .success(let model):
                self?.users = model
            case .failure(let error):
                print("Error occured !!! : \(error.localizedDescription)")
            }
        }
    }

}





