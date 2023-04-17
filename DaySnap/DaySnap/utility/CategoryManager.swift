//
//  CategoryManager.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

//import Foundation
//import Combine
//
//class CategoryManager: ObservableObject {
//    // 用于发布更改的可订阅对象
//    let objectWillChange = PassthroughSubject<Void, Never>()
//
//    @Published var categories = [
//        Category(id: 0, name: "默认", icon: "list.bullet"),
//        Category(id: 1, name: "Love", icon: "heart.circle"),
//        Category(id: 2, name: "学习", icon: "book.circle.fill")
//    ] {
//        didSet {
//            // 发布更改
//            objectWillChange.send()
//        }
//    }
//
//    // 添加一个新分类
//    func addCategory(name: String, icon: String) {
//        let newCategory = Category(id: categories.count, name: name, icon: icon)
//        categories.append(newCategory)
//    }
//
//    // 删除一个分类
//    func deleteCategory(at index: Int) {
//        categories.remove(at: index)
//    }
//}
