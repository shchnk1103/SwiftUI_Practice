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
    @EnvironmentObject var iconSettings: IconNames
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])
    private var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    @State private var showingSettingsView: Bool = false
    
    // THEME
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(todos, id: \.self) { todo in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(colorize(priority: todo.proirity ?? "Normal"))
                            
                            Text(todo.name ?? "Unkown")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.proirity ?? "Unkown")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay {
                                    Capsule()
                                        .stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                }
                        } //: HSTACK
                        .padding(.vertical, 10)
                    } //: LOOP
                    .onDelete(perform: deleteTodo)
                } //: LIST
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .accentColor(themes[theme.themeSettings].themeColor)
                    } //: TOOLBAR
                    
                    ToolbarItem {
                        Button {
                            showingSettingsView.toggle()
                        } label: {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        } //: SETTING BUTTON
                        .accentColor(themes[theme.themeSettings].themeColor)
                        .sheet(isPresented: $showingSettingsView) {
                            SettingsView()
                                .environmentObject(iconSettings)
                        }
                    } //: TOOLBAR ITEM
                } //: TOOLBAR
                
                // MARK: - NO TODO ITEMS
                if todos.count == 0 {
                    EmptyListView()
                }
            } //: ZSTACK
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .overlay(alignment: .bottomTrailing) {
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[theme.themeSettings].themeColor)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .opacity(animatingButton ? 0.2 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[theme.themeSettings].themeColor)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .opacity(animatingButton ? 0.15 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
                    
                    Button {
                        showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background {
                                Circle().fill(Color("ColorBase"))
                            }
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: BUTTON
                    .accentColor(themes[theme.themeSettings].themeColor)
                    .onAppear {
                        animatingButton.toggle()
                    }
                } //: ZSTACK
                .padding(.bottom, 15)
                .padding(.trailing, 15)
            } //: OVERLAY
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
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
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
