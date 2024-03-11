//
//  Profile.swift
//  SheetAnimation
//
//  Created by DoubleShy0N on 2023/10/13.
//

import SwiftUI

struct Profile: Identifiable {
    var id = UUID().uuidString
    var username: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

var profiles = [
    Profile(username: "123", profilePicture: "Pic1", lastMsg: "Hi, I like you", lastActive:  "10:21 AM"),
    Profile(username: "156", profilePicture: "Pic2", lastMsg: "Hi, I like you", lastActive: "10:21 AM"),
    Profile(username: "189", profilePicture: "Pic1", lastMsg: "Hi, I like you", lastActive: "10:21 AM"),
    Profile(username: "329", profilePicture: "Pic2", lastMsg: "Hi, I like you", lastActive: "10:21 AM"),
    Profile(username: "150", profilePicture: "Pic1", lastMsg: "Hi, I like you", lastActive: "10:21 AM")
]
