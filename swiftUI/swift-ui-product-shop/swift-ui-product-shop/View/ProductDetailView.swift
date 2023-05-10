//
//  ProductDetailView.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: ProductViewData
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack {

            Text(product.name)
                .font(.title)
            
            Text(product.rating)
            
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
                }
            }
            
            VStack {
                Text(product.description)
                    .lineLimit(isExpanded ? nil : 1)
                
                Button {
                    isExpanded.toggle()
                } label: {
                    Text(isExpanded ? "Show Less" : "Show More")
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
