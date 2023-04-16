//
//  QuotesViewModel.swift
//  combine-assign
//
//  Created by Kautilya Save on 4/16/23.
//
import Combine
import swift_sense


struct Quotes: Decodable {
    let quotes: [Quote]
    let total: Int
}


struct Quote: Identifiable, Decodable, Hashable {
    let id: Int
    let quote: String
    let author: String
}


class QuotesViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var quotes = [Quote]()
    @Published var randomQuote: String = ""
    
    // No need to do this way in Swift UI -> Just use `@Published` and SwiftUI is smart enough to figure out the subscriber / publisher model.
    private let quotePub = PassthroughSubject<String, Never>()
    var quoteAnyP: AnyPublisher<String, Never> {
        quotePub.eraseToAnyPublisher()
    }
    
    init() {
        quotePub.send("")
    }
    
    
    
    func getQuote() {
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
                let oneQuote = quotesData.quotes.randomElement()?.quote
                self.randomQuote = oneQuote ?? "No Quote available"
                self.quotePub.send(oneQuote ?? "Hello No Quote for the day!")
                self.quotes = quotesData.quotes
            }
            .store(in: &cancellables)
        }
    
    func getRandomQuote() {
        randomQuote = quotes.randomElement()?.quote ?? "No Random quote available"
    }
    
}

struct Constants {
    static let quotesAPIURL = "https://dummyjson.com/quotes"
}
