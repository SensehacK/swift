//
//  ContentView.swift
//  swift-ui-product-shop
//
//  Created by Kautilya Save on 5/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: ProductViewModel = ProductViewModel()

    var body: some View {
        VStack {
            List(vm.products, id: \.id) { product in
                Text(product.name)
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
        ContentView()
    }
}
