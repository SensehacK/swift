//
//  Buttons.swift
//  swift_ui_meal_db
//
//  Created by Kautilya Save on 4/17/23.
//

import Foundation
import SwiftUI

struct HeroButton: View {
    
    var title: String
    var url: URL
    var color: Color = .red
    var textColor: Color = .white
    
    var body: some View {
        Link(destination: url) {
            Text(title)
                .bold()
                .font(.title)
                .frame(width: 350, height: 50)
                .background(color)
                .foregroundColor(textColor)
                .cornerRadius(12)
        }
    }
}
