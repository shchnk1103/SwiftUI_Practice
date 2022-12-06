//
//  Extensions.swift
//  Slot Machine
//
//  Created by 沈晨凯 on 2022/12/3.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded, weight: .heavy))
    }
}
