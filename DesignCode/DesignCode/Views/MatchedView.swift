//
//  MatchedView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/5.
//

import SwiftUI

struct MatchedView: View {
    @Namespace var namespace
    @State var show = false
    
    var body: some View {
        ZStack {
            if !show {
                CourseItem(namespace: namespace, show: $show)
            } else {
                CourseView(namespace: namespace, show: $show)
            }
        }
    }
}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView()
    }
}
