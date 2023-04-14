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
            Image(systemName: todo.image)
            Text(todo.title)
            Spacer()
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(todo: Todo(title: "Hello", image: "cloud"))
    }
}
