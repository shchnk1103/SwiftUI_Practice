//
//  Profile.swift
//  NavigationStackAnimation
//
//  Created by DoubleShy0N on 2023/7/24.
//

import SwiftUI

/// Sample Profile Model
struct Profile: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

/// Sample Profile Data
var profiles = [
    Profile(userName: "iJustine", profilePicture: "Pic1", lastMsg: "Hi world", lastActive: "10:25 AM"),
    Profile(userName: "John", profilePicture: "Pic2", lastMsg: "Hi friend", lastActive: "6:25 AM"),
    Profile(userName: "Emily", profilePicture: "Pic3", lastMsg: "Nooo...", lastActive: "10:25 PM"),
    Profile(userName: "Wick", profilePicture: "Pic4", lastMsg: "404 Not Found", lastActive: "11:25 PM"),
    Profile(userName: "Kelly", profilePicture: "Pic5", lastMsg: "Do Not Touch Me", lastActive: "2:25 PM"),
]
