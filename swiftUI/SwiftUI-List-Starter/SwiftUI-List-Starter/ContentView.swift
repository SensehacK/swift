//
//  ContentView.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        HStack {
            Image("wish-i-knew")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Hello !!!")
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text("Subtitle!!!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
            }
            .padding(.vertical)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
