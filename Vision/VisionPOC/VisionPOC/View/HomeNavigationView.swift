//
//  HomeNavigationView.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/21/23.
//

import Foundation

import SwiftUI

struct HomeNavigationView: View {
    @State var text: String = ""
    
    var body: some View {
//        firstNavigationSplitView
        secondNavigationView
    }
}

#Preview(windowStyle: .automatic) {
    HomeNavigationView()
}



extension HomeNavigationView {
    private var firstNavigationSplitView: some View {
        Group {
            NavigationSplitView {
                TabView {
                    Text("Tab One")
                        .tabItem { Label("Featured", systemImage: "star") }
                        .onAppear { text = "Tab One's Items" }
                    Text("Tab Two")
                        .tabItem { Label("List", systemImage: "list.bullet") }
                        .onAppear { text = "Items of Tab Two" }
                }.tabViewStyle(.page)
                List {
                    Text(text)
                        .onChange(of: text) { _, newValue in
                            text = newValue
                        }
                }
            } detail: {
                // some code
            }
            .navigationTitle("Content")
            .padding()
        }
    }
    
    
    
    
    private var secondNavigationView: some View {
        
        
        TabView {
            
            Text("Tab One")
                .tabItem { Label("Featured", systemImage: "star") }
                .onAppear { text = "Tab One's Items" }
            
            
            Text("Tab Two")
                .tabItem { Label("List", systemImage: "list.bullet") }
                .onAppear { text = "Items of Tab Two" }
            
            
        }
    }
}
