//
//  VideoModel.swift
//  Africa
//
//  Created by 沈晨凯 on 2022/11/14.
//

import SwiftUI

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    // Computed Property
    var thumbnail: String {
        "video-\(id)"
    }
}
