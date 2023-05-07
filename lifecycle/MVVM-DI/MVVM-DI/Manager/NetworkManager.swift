//
//  NetworkManager.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import Foundation
import SwiftSense
import Combine

class NetworkManager {
    // Private
    var anyCancellables = Set<AnyCancellable>()
    
    var users = CurrentValueSubject<UsersConsumableViewModel?, Error>(nil)
    
    @Published var userData: UsersConsumableViewModel?
    
//    static var shared: NetworkManager = NetworkManager()
//    private init() { }
    
    func getData(completion: @escaping(Result<UsersConsumableViewModel, Error>) -> Void) {
        let url: String = "https://dummyjson.com/users"
        print("Hello")
        CombineNetwork
            .shared
            .fetchData(url: url, type: UsersAPI.self)
            .sink { complete in
                switch complete {
                case .finished:
                    print("Finished Successfully")
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
                print("Completion")
            } receiveValue: { [weak self] data in
                print("Received value")
                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
                let resultData = UsersConsumableViewModel(usersData: userArray)
                self?.users.value = resultData
                completion(.success(resultData))
            }
            .store(in: &anyCancellables)
    }
    
    
    func getData2() {
        let url: String = "https://dummyjson.com/users"

        CombineNetwork
            .shared
            .fetchData(url: url, type: UsersAPI.self)
            .sink { complete in
                switch complete {
                case .finished:
                    print("Finished Successfully")
                case .failure(let error):
                    print(error)
                }
                print("Completion2 ")
            } receiveValue: { [weak self] data in
                print("Received value 2")
                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
                let resultData = UsersConsumableViewModel(usersData: userArray)
                self?.users.value = resultData
                self?.users.send(completion: .finished)

            }
            .store(in: &anyCancellables)
    }
    

    func getDataUsingAsyncAwait() {
        let url: String = "https://dummyjson.com/users"
        print("Hello getDataUsingAsyncAwait")
        
        
        Task {
            do {
                let data = try await AsyncNetwork.shared.fetchData(url: url, type: UsersAPI.self)
                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
                let resultData = UsersConsumableViewModel(usersData: userArray)
                users.send(resultData)
                userData = resultData
            } catch {
                print("error")
            }
        }
    }
    
    
    func getDataUsingCombineLibSubscription() {
        let url: String = "https://dummyjson.com/users"
        
        
        CombineNetwork
            .shared
            .fetchData(url: url, type: UsersAPI.self)
            .sink { complete in
                switch complete {
                case .finished:
                    print("Finished Successfully")
                case .failure(let error):
                    print(error)
//                    completion(.failure(error))
                }
                print("Completion")
            } receiveValue: { [weak self] data in
                print("Received value")
                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
                let resultData = UsersConsumableViewModel(usersData: userArray)
                self?.userData = resultData
//                completion(.success(resultData))
            }
            .store(in: &anyCancellables)
        
    }
    
    

}
