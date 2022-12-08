//
//  AddTodoView.swift
//  Todo
//
//  Created by DoubleShy0N on 2022/12/8.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTY
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["High", "Normal", "Low"]
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                    
                    // MARK: - TODO PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) { priority in
                            Text(priority)
                        } //: FOR
                    } //: PICKER
                    .pickerStyle(.segmented)
                    
                    // MARK: - SAVE BUTTON
                    Button {
                        if name != "" {
                            let todo = Todo(context: viewContext)
                            todo.name = name
                            todo.proirity = priority
                            
                            do {
                                try viewContext.save()
                                print("New todo: \(todo.name ?? ""), Priority: \(todo.proirity ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            errorShowing = true
                            errorTitle = "Invalid Name"
                            errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        } //: IF
                        dismiss.callAsFunction()
                    } label: {
                        Text("Save")
                    } //: BUTTON
                } //: FORM
            } //: VSTACK
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                }

            }
            .alert(isPresented: $errorShowing) {
                Alert(title: Text("errorTitle"), message: Text(errorTitle), dismissButton: .default(Text("OK")))
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
