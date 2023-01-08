//
//  ExploreView.swift
//  DesignCode
//
//  Created by DoubleShy0N on 2023/1/8.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            coursesSection
                .safeAreaInset(edge: .top, content: {
                    Color.clear.frame(height: 70)
                })
                .overlay {
                    NavigationBarView(title: "Recent", hasScrolled: .constant(true))
                }
                .background(Image("Blob 1").offset(x: -100, y: -400))
        }
    }
    
    var coursesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(courses) { course in
                    SmallCourseItem(course: course)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
