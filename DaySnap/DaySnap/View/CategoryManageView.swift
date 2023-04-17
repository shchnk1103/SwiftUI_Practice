//
//  CategoryManageView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

import SwiftUI

// TODO: fenlei
struct CategoryManageView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var selectedSymbol: String = ""
    @State private var name: String = ""
    
    var body: some View {
        List {
            ForEach(categories) { category in
                HStack {
                    Image(systemName: category.icon)
                        .font(.title3)
                    
                    Text(category.name)
                }
            }
            .onDelete(perform: delete)
            
            VStack(alignment: .leading) {
                HStack {
                    TextField("名称", text: $name)
                    
                    Text("图标")
                        .foregroundColor(.primary.opacity(0.8))
                    
                    Picker(selection: $selectedSymbol) {
                        ForEach(sfSymbols, id: \.self) { sfSymbol in
                            Image(systemName: sfSymbol.name)
                                .tag(sfSymbol.name)
                        }
                    } label: {
                        Text("选择图标")
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80)
                }
                
                Button {
                    save()
                } label: {
                    Text("保存")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(height: 36)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.black, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                .disabled(name.isEmpty)
            }
            .padding()
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .strokeStyle(cornerRadius: 8)
        }
        .frame(maxHeight: .infinity)
        .navigationTitle("分类管理")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    // MARK: functions
    private func delete(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
        
        saveCategories()
    }

    private func save() {
        categories.append(Category(id: categories.count, name: name, icon: selectedSymbol))
        
        saveCategories()
        
        name = ""
    }
    
    private func saveCategories() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(categories) {
            UserDefaults.standard.set(encoded, forKey: "categories")
        }
    }
}

struct CategoryManageView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryManageView()
    }
}
