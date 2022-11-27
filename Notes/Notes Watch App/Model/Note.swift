//
//  Note.swift
//  Notes Watch App
//
//  Created by 沈晨凯 on 2022/11/26.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
