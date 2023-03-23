////
////  LimitInputView.swift
////  DaySnap
////
////  Created by DoubleShy0N on 2023/3/13.
////
//
//import SwiftUI
//
//struct LimitInputView: UIViewRepresentable {
//    @Binding var text: String
//    let textField = UITextField()
//    var shouldChangeText = true
//
//    func makeUIView(context: Context) -> UITextField {
//        textField.delegate = context.coordinator
//        textField.textAlignment = .center
//        textField.text = text
//        return textField
//    }
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//        var parent: LimitInputView
//
//        init(_ parent: LimitInputView) {
//            self.parent = parent
//        }
//
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            // 返回键返回
//            if string == "\n" {
//                textField.resignFirstResponder()
//                return false
//            }
//
//            // 判断是否为删除操作
//            if string.isEmpty {
//                // 允许删除操作
//                textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: "") ?? ""
//                return true
//            }
//
//            // 只允许输入一个字符
//            if textField.text?.count ?? 0 >= 1 && string.count > 0 {
//                return false
//            }
//
//            // 只允许输入中文、英文和 Emoji 表情
//            if string.rangeOfCharacter(from: .letters) == nil && string.rangeOfCharacter(from: .punctuationCharacters) == nil && !string.isEmoji {
//                return false
//            }
//
//            // 允许输入
//            return true
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        if shouldChangeText {
//            uiView.text = text
//        }
//    }
//}
