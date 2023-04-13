//
//  ContentView.swift
//  NavigationView
//
//  Created by Kautilya Save on 4/13/23.
//

import SwiftUI



struct ContentView: View {
    
    
    @State var backgroundColor: Color = .green
    @State var currentColor: String = "Green"
    
    var body: some View {
        
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Text(currentColor)
                        .font(.largeTitle)
                    
                    Button {
                        backgroundColor = .gray
                        currentColor = "Gray"
                    } label: {
                        Text("PRESS ME!")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.gray)
                            .cornerRadius(10)
                    }
                }
                .navigationTitle(currentColor)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
