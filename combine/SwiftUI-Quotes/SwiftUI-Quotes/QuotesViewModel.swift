//
//  QuotesViewModel.swift
//  SwiftUI-Quotes
//
//  Created by Kautilya Save on 4/15/23.
//

import Combine
import swift_sense

class QuotesViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var quotes = [Quote]()
    
    func getQuotesData() {
        AsyncNetwork.shared.fetchData(url: Constants.quotesAPIURL, type: Quotes.self)
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
                self.quotes = quotesData.quotes
            }
            .store(in: &cancellables)
        }
    
}

struct Constants {
    static let quotesAPIURL = "https://dummyjson.com/quotes"
}
