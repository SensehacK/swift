//
//  ContentView.swift
//  Binding
//
//  Created by Kautilya Save on 4/13/23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var backgroundColor: Color = .green
    @State var currentColor: String = "Green"
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
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
                AnotherView(backgroundColor: $backgroundColor, currentColor: $currentColor)
                AnotherOneView(backgroundColor: $backgroundColor, currentColor: $currentColor)
            }
            
        }
    }
}




struct AnotherView: View {
    
    @Binding var backgroundColor: Color
    @Binding var currentColor: String
    
    var body: some View {
        
        Button {
            backgroundColor = .indigo
            currentColor = "Indigo"
        } label: {
            Text("Indigo!")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.indigo)
                .cornerRadius(10)
        }
        
    }
    
}


struct AnotherOneView: View {
    
    @Binding var backgroundColor: Color
    @Binding var currentColor: String
    
    var body: some View {
        
        Button {
            backgroundColor = .red
            currentColor = "Red"
        } label: {
            Text("Red!")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(.red)
                .cornerRadius(10)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
