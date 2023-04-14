//
//  ListView.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI




struct ListView: View {
    
    @State var listData: [Todo] = [
        Todo(title: "First", isCompleted: false),
        Todo(title: "2", isCompleted: true),
        Todo(title: "Fi2rst", isCompleted: false),
        Todo(title: "First", isCompleted: false)
    ]
        
    var body: some View {
        List {
            ForEach(listData, id: \.id) { todo in
                ListRowView(todo: todo)
            }
        }
        .navigationTitle("TODO")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        
    }
}


