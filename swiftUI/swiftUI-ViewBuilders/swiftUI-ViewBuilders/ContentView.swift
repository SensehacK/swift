//
//  ContentView.swift
//  swiftUI-ViewBuilders
//
//  Created by Kautilya Save on 4/23/23.
//

import SwiftUI
import swift_sense

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("Trials")
                .withDefaultButtonFormatting(backgroundColor: .red)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Moved to swift_sense 0.1.9
//struct DefaultButtonViewModifier: ViewModifier {
//
//    let backgroundColor: Color
//
//    init(backgroundColor: Color = .blue) {
//        self.backgroundColor = backgroundColor
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .foregroundColor(.white)
//            .frame(height: 55)
//            .frame(maxWidth: .infinity)
//            .background(backgroundColor)
//            .cornerRadius(10)
//            .shadow(radius: 10)
//    }
//
//}
//
//extension View {
//
//    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
//        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
//    }
//
//}
