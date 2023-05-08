//
//  DummyJsonUserService.swift
//  MVVM-DI
//
//  Created by Kautilya Save on 5/8/23.
//

import Combine
import SwiftSense

class DummyJsonUserService: NetworkManagerDelegate {
    // Private
    var anyCancellables = Set<AnyCancellable>()
    
    func getData(completion: @escaping (Result<UsersConsumableViewModel, Error>) -> Void) {
        let url: String = "https://dummyjson.com/users"
        print("Hello https://dummyjson.com/users")
        
        Task {
            
            do {
                let data = try await AsyncNetwork.shared.fetchData(url: url, type: DUsersAPI.self)
                let userArray = data.users.map { DUserConsumableViewModel(user: $0) }
                let userConsumableViewModel = userArray.map { UserConsumableViewModel(name: $0.name, id: $0.id) }
                let resultData = UsersConsumableViewModel(usersData: userConsumableViewModel)
                
                
                completion(.success(resultData))
            } catch {
                print("error")
            }
            
            
            
        }
        
        
//        CombineNetwork.shared
//            .fetchData(url: url, type: DUsersAPI.self)
//            .sink { complete in
//                print("Completion received")
//            } receiveValue: { data in
//                print("Data received \(data)")
//            }
//            .store(in: &anyCancellables)

        
        
//        CombineNetwork
//            .shared
//            .fetchData(url: url, type: DUsersAPI.self)
//            .sink { complete in
//                switch complete {
//                case .finished:
//                    print("Finished Successfully")
//                case .failure(let error):
//                    print(error)
//                    completion(.failure(error))
//                }
//                print("Completion")
//            } receiveValue: { data in
//                print("Received value")
////                let userArray = data.users.map { UserConsumableViewModel(name: "Hello", id: 1) }
////                let resultData = UsersConsumableViewModel(usersData: userArray)
//                completion(.success(UsersConsumableViewModel(usersData: [UserConsumableViewModel(name: "asaq", id: 1)])))
////                completion(.success(resultData))
//            }
//            .store(in: &anyCancellables)
    }
    
    
    
    
}
