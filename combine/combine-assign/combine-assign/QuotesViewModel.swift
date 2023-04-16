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

    func getQuote() {
        AsyncNetwork.shared.fetchData(url: Constants.quotesAPIURL, type: Quotes.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finish")
                }
            }
            receiveValue: { [weak self] quotesData in
                let quotes = quotesData.quotes
                self?.quotes = quotes
                self?.getRandomQuote()
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
