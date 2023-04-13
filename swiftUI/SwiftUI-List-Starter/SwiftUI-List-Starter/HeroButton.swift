//
//  HeroButton.swift
//  SwiftUI-List-Starter
//
//  Created by Kautilya Save on 4/13/23.
//

import SwiftUI

struct HeroButton: View {
    
    var title: String
    var url: URL
    
    var body: some View {
        Link(destination: url) {
            Text(title)
                .bold()
                .font(.title)
                .frame(width: 350, height: 50)
                .background(Color(.systemRed))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}
