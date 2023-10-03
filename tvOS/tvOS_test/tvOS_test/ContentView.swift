//
//  ContentView.swift
//  tvOS_test
//
//  Created by Save, Kautilya on 10/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, SensehacK!")
        }
        .onAppear {
            DeviceTypeC().testDevice()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct DeviceTypeC {
    
    func testDevice() {
        print(UIDevice.current)
        print(UIDevice.current.model.lowercased())
        
    }
}
