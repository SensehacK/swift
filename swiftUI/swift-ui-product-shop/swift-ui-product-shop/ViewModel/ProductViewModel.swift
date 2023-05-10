//
//  ProductViewModel.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import Foundation

protocol ProductFetcher: AnyObject {
    func fetchData() async
}

@MainActor
class ProductViewModel: ObservableObject, ProductFetcher {
    
    @Published var products: [ProductViewData]
    
    let networkService: ProductNetworkServiceble
    
    init(products: [ProductViewData] = [], networkService: ProductNetworkServiceble = DProductService()) {
        self.products = products
        self.networkService = networkService
    }
    
    func fetchData() async {
        products = await networkService.fetchData()
    }

}


// Consumable ViewModel
struct ProductViewData {
    
    var id: Int {
        product.id
    }
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    
    var name: String {
        "\(product.brand) - \(product.title)"
    }
    
    
    
    
}


