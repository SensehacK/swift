//
//  DProductService.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import Foundation

protocol ProductNetworkServiceble {
    func fetchData() async -> [ProductViewData]
}


class DProductService: ProductNetworkServiceble {

    func fetchData() async -> [ProductViewData] {
        do {
            let data: ProductsAPI = try await NetworkManager.shared.fetchData(url: URLConstants.productAPIURL)
            
            return data.products.map(ProductViewData.init)
            
        } catch {
            print(error.localizedDescription)
        }

        return []
    }
    
    
}
