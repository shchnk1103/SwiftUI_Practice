//
//  StatusModel.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/16.
//

import Foundation

struct Status: Identifiable, Hashable {
    var id: Int
    var name: String
}

var statuses = [
    Status(id: 0, name: "全部"),
    Status(id: 1, name: "未打卡"),
    Status(id: 2, name: "已打卡")
]
