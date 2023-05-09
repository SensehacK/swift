//
//  JSONPlaceholderUserService.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/7/23.
//

import Foundation
import SwiftSense
import Combine

class JSONPlaceholderUserService: NetworkManagerDelegate {
    // Private
    var anyCancellables = Set<AnyCancellable>()
    
    var users = CurrentValueSubject<UsersConsumableViewModel?, Error>(nil)
    
    @Published var userData: UsersConsumableViewModel?
    
//    static var shared: NetworkManager = NetworkManager()
//    private init() { }
    
    func getData(completion: @escaping(Result<UsersConsumableViewModel, Error>) -> Void) {
        let url: String = "https://jsonplaceholder.typicode.com/users"

        print("Hello https://jsonplaceholder.typicode.com/users")
//        var users: [UsersAPIElement] = []
        CombineNetwork
            .shared
            .fetchData(url: url, type: UsersAPIElement.self)
            .sink { completion in
                print("Completion")
            } receiveValue: { result in
//                print(result)
                let returnedUsers = result
                
                let userArray = returnedUsers.map { JsonPlaceholderUserConsumableViewModel(userData: $0) }
                let userConsumableViewModel = userArray.map { UserConsumableViewModel(name: $0.name, id: $0.id) }
                let resultData = UsersConsumableViewModel(usersData: userConsumableViewModel)
                completion(.success(resultData))
            }
            .store(in: &anyCancellables)

        
//        CombineNetwork
//            .shared
//            .fetchData(url: url, type: DUsersAPI.self)
//
//
//
////            .fetchData(url: url, type: UsersAPIElement.self)
////            .fetchData(url: url, type: DUsersAPI.self)
//            .sink { complete in
//                switch complete {
//                case .finished:
//                    print("Finished Successfully")
//                case .failure(let error):
//                    print(error)
//                    completion(.failure(error))
//                }
//                print("Completion")
//            } receiveValue: { [weak self] data in
//                print("Received value")
//
////                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
////                let resultData = UsersConsumableViewModel(usersData: userArray)
////                self?.users.value = resultData
////                completion(.success(resultData))
//            }
//            .store(in: &anyCancellables)
    }
    
    
//    func getDataUsingCombineWithSubjectPublisher() {
//        let url: String = "https://dummyjson.com/users"
//
//        CombineNetwork
//            .shared
//            .fetchData(url: url, type: DUsersAPI.self)
//            .sink { complete in
//                switch complete {
//                case .finished:
//                    print("Finished Successfully")
//                case .failure(let error):
//                    print(error)
//                }
//                print("Completion2 ")
//            } receiveValue: { [weak self] data in
//                print("Received value 2")
//                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
//                let resultData = UsersConsumableViewModel(usersData: userArray)
//                self?.users.value = resultData
//                self?.users.send(completion: .finished)
//
//            }
//            .store(in: &anyCancellables)
//    }
    

//    func getDataUsingAsyncAwait() {
//        let url: String = "https://dummyjson.com/users"
//        print("Hello getDataUsingAsyncAwait")
//
//
//        Task {
//            do {
//                let data = try await AsyncNetwork.shared.fetchData(url: url, type: DUsersAPI.self)
//                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
//                let resultData = UsersConsumableViewModel(usersData: userArray)
//                users.send(resultData)
//                userData = resultData
//            } catch {
//                print("error")
//            }
//        }
//    }
    
    
//    func getDataUsingCombineLibWithPublisherSubscription() {
//        let url: String = "https://dummyjson.com/users"
//
//
//        CombineNetwork
//            .shared
//            .fetchData(url: url, type: DUsersAPI.self)
//            .sink { complete in
//                switch complete {
//                case .finished:
//                    print("Finished Successfully")
//                case .failure(let error):
//                    print(error)
////                    completion(.failure(error))
//                }
//                print("Completion")
//            } receiveValue: { [weak self] data in
//                print("Received value")
//                let userArray = data.users.map { UserConsumableViewModel(userData: $0) }
//                let resultData = UsersConsumableViewModel(usersData: userArray)
//                self?.userData = resultData
////                completion(.success(resultData))
//            }
//            .store(in: &anyCancellables)
//
//    }
    
    

}
