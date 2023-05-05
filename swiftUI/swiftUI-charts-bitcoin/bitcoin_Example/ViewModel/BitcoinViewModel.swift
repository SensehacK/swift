//
//  BitcoinViewModel.swift
//  bitcoin_Example
//
//  Created by Kautilya Save on 5/5/23.
//

import Foundation

@MainActor
class BitcoinViewModel: ObservableObject, BitcoinFetcherProtocol {

    
    @Published var bitcoin: Bitcoin?
    
    // private
//    let loader: BitcoinFetcherProtocol?
//
//    init(loader: BitcoinFetcherProtocol) {
//        self.loader = loader
//    }
    
    func loadData() async {
        do {
            bitcoin = try await NetworkManager.shared.fetchData(url: URLConstants.apiURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}








// Consumable ViewModel
struct BitcoinDisplayModel {
    let bitcoin: Bitcoin
    
}
