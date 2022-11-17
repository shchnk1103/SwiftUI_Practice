//
//  PageModel.swift
//  Pinch
//
//  Created by 沈晨凯 on 2022/11/8.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
