//
//  ListRowView.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI

struct ListRowView: View {
    let todo: Todo
    
    var body: some View {
        HStack {
            Image(systemName:  todo.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(todo.isCompleted ? .green : .red)
            Text(todo.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = Todo(title: "Hello", isCompleted: true)
    static var item2 = Todo(title: "Hello", isCompleted: false)
    
    static var previews: some View {
        Group {
            ListRowView(todo: item1)
            ListRowView(todo: item2)
        }
        .previewLayout(.sizeThatFits)
        
    }
}
