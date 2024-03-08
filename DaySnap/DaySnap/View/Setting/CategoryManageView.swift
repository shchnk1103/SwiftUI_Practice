//
//  CategoryManageView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

import SwiftUI

struct CategoryManageView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var userViewModel: UserViewModel
    // 自定义颜色
    @AppStorage("colorCustom") var colorCustom: String = ""
    
    @State private var selectedSymbol: String = ""
    @State private var name: String = ""
    
    var body: some View {
        List {
            ForEach(categories) { category in
                HStack {
                    Image(systemName: category.icon)
                        .font(.title3)
                    
                    Text(category.name)
                    
                    Spacer()
                    
                    if !userViewModel.isSubscriptionActive {
                        Image(systemName: "lock.fill")
                    }
                }
            }
            .onDelete(perform: userViewModel.isSubscriptionActive ? delete : nil)
            
            if userViewModel.isSubscriptionActive {
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
                            .foregroundColor(
                                colorScheme == .dark
                                ? (colorCustom == ""
                                   ? .black.opacity(0.8)
                                   : .white.opacity(0.8))
                                : (colorCustom == ""
                                   ? .white
                                   : .white.opacity(0.8))
                            )
                            .frame(height: 36)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                            )
                            .buttonBackgroundColor()
                    }
                    .disabled(name.isEmpty)
                    
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .strokeStyle(cornerRadius: 8)
            } else {
                Text("抱歉，暂时只有高级会员才能创建新的分类")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
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
        guard !name.isEmpty else {
            print("Error: name must not be empty.")
            return
        }
        
        let newCategory = Category(id: categories.count, name: name, icon: selectedSymbol)
        categories.append(newCategory)
        
        saveCategories()
        
        name = ""
    }
    
    private func saveCategories() {
        let sortedCategories = categories.sorted { $0.id < $1.id }
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(sortedCategories)
            UserDefaults.standard.set(encoded, forKey: "categories")
        } catch {
            print("Error encoding categories: \(error.localizedDescription)")
        }
    }
}

struct CategoryManageView_Previews: PreviewProvider {
    static let userViewModel = UserViewModel()
    
    static var previews: some View {
        CategoryManageView()
            .environmentObject(userViewModel)
    }
}
