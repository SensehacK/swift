//
//  ProductDetailView.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: ProductViewData

    var body: some View {
        VStack {
//            AsyncImage(url: product.heroImage) { image in
//                image.resizable()
//                    .frame(width: 300, height: 300)
//            } placeholder: {
//                ProgressView()
//            }
            
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<product.imagesURL.count, id: \.self) {
                        let imageURL = product.imagesURL[$0]
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .frame(width: 300, height: 300)
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }
                    
//                    ForEach(product.imagesURL) { image in
//
//                    }
                }
                
                
            }
            
        }
        .padding()

    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: -1, title: "Hello", description: "ASA", price: 23, discountPercentage: 12, rating: 214, stock: 21, brand: "asfa", category: "afaf", thumbnail: "asfa", images: ["https://placehold.co/300.png", "https://placehold.co/300.png"])
        ProductDetailView(product: ProductViewData(product: product))
    }
}
