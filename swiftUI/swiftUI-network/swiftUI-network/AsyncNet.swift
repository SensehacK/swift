//
//  AsyncNet.swift
//  swiftUI-network
//
//  Created by Kautilya Save on 4/15/23.
//

import Foundation
import Combine

class QuotesVM: ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var quotes = [Quote]()
    
    
    func getQuotesData() {
        
        AsyncNetwork.shared.getData(url: "https://dummyjson.com/quotes", type: Quotes.self)
            .sink { completion in
                print("Error failure")
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finish")
                }
            }
            receiveValue: { quotesData in
                print("Got the data!")
                //            print(quotesData.)
                print(quotesData.quotes)
                self.quotes = quotesData.quotes
                
            }
            .store(in: &cancellables)
        }
    
}
