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
    
    // THEME
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                        .padding()
                        .background {
                            Color(UIColor.tertiarySystemFill)
                        }
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
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
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background {
                                themes[theme.themeSettings].themeColor
                            }
                            .cornerRadius(9)
                            .foregroundColor(.white)
                    } //: BUTTON
                } //: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            } //: VSTACK
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                }

            } //: TOOLBAR
            .alert(isPresented: $errorShowing) {
                Alert(title: Text("errorTitle"), message: Text(errorTitle), dismissButton: .default(Text("OK")))
            }
        } //: NAVIGATION
        .accentColor(themes[theme.themeSettings].themeColor)
    }
}

// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
