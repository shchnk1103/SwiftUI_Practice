//
//  StoreManager.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/22.
//

import Foundation
import StoreKit

class StoreManager: ObservableObject {
    @Published var products: [Product] = []
    
    func fetchProducts() {
        Task {
            do {
                let products = try await Product.products(for: [
                    "daysnap_36_1y_1w0",
                    "daysnap_6_1m_1w0",
                    "daysnap_12_1q_1w0"
                ])
                DispatchQueue.main.async {
                    self.products = products
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    func purchase(product: Product) {
//        Task {
//            do {
//                let result = try await product.purchase()
//                switch result {
//                case .success(let verification):
//                    switch verification {
//                    case .unverified(let signedType, let verificationError):
//                        print(signedType)
//                        print(verificationError)
//                    case .verified(let signedType):
//                        print(signedType.productID)
//                    }
//                case .userCancelled:
//                    break
//                case .pending:
//                    break
//                @unknown default:
//                    break
//                }
//            }
//        }
//    }
}
