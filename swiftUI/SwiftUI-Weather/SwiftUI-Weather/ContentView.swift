//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Kautilya Save on 4/12/23.
//

import SwiftUI

struct ContentView: View {
    
    let gradientColors: [Color] = [.blue, .white, .green]
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: gradientColors),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                
//                Color(.blue)
//                Spacer()
                VStack {
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                        .foregroundColor(.white)
                    Text("Save")
                        .foregroundColor(.red)
                    ZStack {
                        Text("Kautilya")
                            .foregroundColor(.red)
                    }
                }
                .padding()
//                Spacer()
                
            }
            
            
            
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
