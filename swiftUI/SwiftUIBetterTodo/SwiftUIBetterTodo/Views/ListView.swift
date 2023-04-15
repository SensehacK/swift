//
//  ListView.swift
//  SwiftUIBetterTodo
//
//  Created by Kautilya Save on 4/14/23.
//

import SwiftUI


struct ListView: View {
    @EnvironmentObject var listVM: TodoListViewModel
    
    var body: some View {
        ZStack {
            if listVM.items.isEmpty {
                EmptyListView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listVM.items, id: \.id) { todo in
                        ListRowView(todo: todo)
                            .onTapGesture {
                                withAnimation {
                                    listVM.completeItem(todo: todo)
                                }
                            }
                    }
                    .onDelete(perform: listVM.deleteItem)
                    .onMove(perform: listVM.moveItem)
                    
                }
                
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
        .environmentObject(TodoListViewModel())
        
    }
}


