//
//  ContentView.swift
//  Alert
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @State private var destructiveAlert = false
    
    var body: some View {
        VStack(spacing: 20) {

            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
            Button("Show Alert with Message") {
                showingAlert2 = true
            }
            .alert(isPresented: $showingAlert2) {
                Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
            }
            
            
            Button("Show Alert with Destruction") {
                destructiveAlert = true
            }
            .alert("Title", isPresented: $destructiveAlert, actions: {
                Button("Delete", role: .destructive, action: {
                    print("Do something destructive")
                })
            }, message: {
                Text("Alert with Destructive option")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
