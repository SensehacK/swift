//
//  AdaptiveContainer.swift
//  SwiftUI-Adaptive-Geometry-Reader
//
//  Created by Kautilya Save on 5/9/23.
//
import SwiftUI

struct AdaptiveContainerView<Content: View>: View {
    
    @State private var width:CGFloat = 0
    @State private var height:CGFloat = 0
    
    var content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.clear
            if width > height {
                HStack { content }
            } else {
                VStack { content }
            }
        }
        .getSize { size in
            width = size.width
            height = size.height
        }
    }
    
}

extension View {
    func getSize(onChange: @escaping(CGSize) -> Void) -> some View {
        background(
            GeometryReader{ reader in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: reader.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue nextvalue: () -> CGSize) {}
}
