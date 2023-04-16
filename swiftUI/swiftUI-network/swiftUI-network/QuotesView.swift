//
//  QuotesView.swift
//  swiftUI-network
//
//  Created by Kautilya Save on 4/15/23.
//

import SwiftUI


struct Quotes: Decodable {
    let quotes: [Quote]
    let total: Int
}


struct Quote: Identifiable, Decodable, Hashable {
    let id: Int
    let quote: String
    let author: String
}


struct QuotesView: View {
    
    @ObservedObject var viewModel = QuotesVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.quotes, id: \.self) { value in
                            Text(value.quote)
                                .padding()
                            
                            VStack(alignment: .trailing) {
                                Text("-\(value.author)")
                                    
                            }
                            .padding(.horizontal, 36)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .navigationTitle("Quotes")
            }
            
        }.onAppear {
            viewModel.getQuotesData()
        }
    }
    
}


struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
