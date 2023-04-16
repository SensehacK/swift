//
//  ContentView.swift
//  combine-assign
//
//  Created by Kautilya Save on 4/16/23.
//

import SwiftUI
import Combine

struct QuotesView: View {
    @State var textField = "Hello User"
    @ObservedObject var viewModel = QuotesViewModel()
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.randomQuote)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                Text(textField)
                
                VStack {
                    Button {
                        viewModel.getRandomQuote()
                    } label: {
                        Text("Get Random Quote")
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(18)
                    }
                }
                .padding()
            }
            .navigationTitle("Random Quote")
            .padding()
        }
        .onAppear { viewModel.getQuote() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
