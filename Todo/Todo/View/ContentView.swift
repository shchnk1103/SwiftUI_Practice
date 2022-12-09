//
//  ContentView.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/8.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])
    private var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unkown")
                            
                            Spacer()
                            
                            Text(todo.proirity ?? "Unkown")
                        }
                    } //: LOOP
                    .onDelete(perform: deleteTodo)
                } //: LIST
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    } //: TOOLBAR
                    
                    ToolbarItem {
                        Button {
                            showingAddTodoView.toggle()
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        } //: BUTTON
                        .sheet(isPresented: $showingAddTodoView) {
                            AddTodoView()
                                .environment(\.managedObjectContext, viewContext)
                        }
                    } //: TOOLBAR ITEM
                } //: TOOLBAR
                
                // MARK: - NO TODO ITEMS
                if todos.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
            Text("Select an item")
        } //: NAVIGATION
    }
    
    // MARK: - FUNCTION
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            viewContext.delete(todo)
            
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
