//
//  ListView.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI


struct Todo: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

struct ListView: View {
    
    @State var listData: [Todo] = [
        Todo(title: "First", image: "soccerball.circle"),
        Todo(title: "2", image: "circle.dotted"),
        Todo(title: "Fi2rst", image: "cloud"),
        Todo(title: "First", image: "circle")
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


