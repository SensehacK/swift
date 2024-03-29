//
//  ContentView.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject var vm: ProductViewModel = ProductViewModel()
    
    var body: some View {
        VStack {
            
            NavigationView {
                List(vm.products, id: \.id) { product in
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        HStack {
                            VStack {
                                AsyncImage(url: product.thumbnail) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)

                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .frame(width: 60, height: 60)
                            Text(product.name)
                        }
                    }
                }
            }
        }
        .padding()
        .task {
            await vm.fetchData()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
