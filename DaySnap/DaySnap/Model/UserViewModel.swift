//
//  UserViewModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

import Foundation
import RevenueCat

class UserViewModel: ObservableObject {
    @Published var isSubscriptionActive = false
    
    init() {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            self.isSubscriptionActive = customerInfo?.entitlements.all["pro"]?.isActive == true
        }
    }
}
