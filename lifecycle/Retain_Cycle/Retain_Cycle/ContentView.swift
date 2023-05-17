//
//  ContentView.swift
//  Retain_Cycle
//
//  Created by Kautilya Save on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
//            let vm = RetainViewModel()
            var vm: RetainViewModel? = RetainViewModel()
            vm?.initializeTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                print("Nillifying after 10 secs")
                vm = nil
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
