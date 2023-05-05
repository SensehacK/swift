//
//  ContentView.swift
//  bitcoin_Example
//
//  Created by Kautilya Save on 5/5/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @ObservedObject var viewModel: BitcoinViewModel = BitcoinViewModel()
    
    var body: some View {
        VStack {
            if let data = viewModel.bitcoin {
                Text(data.name)
                
            
                Chart {
                    ForEach(Array(data.priceLastTenHours.enumerated()), id: \.offset) { index, value in
                        
                        LineMark(x: .value("", index),
                                 y: .value("", value))
                        
                        
                    }
                }
//                .chartYScale(domain: 25000...36000)
                .chartYScale(domain: data.priceLastTenHours.min()!...data.priceLastTenHours.max()!)
                .frame(height: 250)
                
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
        
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
