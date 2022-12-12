//
//  GuidView.swift
//  Honeymoon
//
//  Created by DoubleShy0N on 2022/12/12.
//

import SwiftUI

struct GuidView: View {
    // MARK: - PROPERTY
    @Environment(\.dismiss) var dismiss
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                
                Spacer()
                
                Text("Get Started!")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                Text("Discover and pick the perfect destination for your romantic Honeymoon!")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .leading, spacing: 25) {
                    GuidComponent(
                        title: "Like",
                        subtitle: "Swipe right",
                        description: "Do you like this destination? Touch the screen and swipe right. It will be saved to the favourites.",
                        icon: "heart.circle"
                    )
                    
                    GuidComponent(
                        title: "Dismiss",
                        subtitle: "Swipe left",
                        description: "Would you rather skip this place? Touch the screen and swipe left. You will no longer see it.",
                        icon: "xmark.circle"
                    )
                    
                    GuidComponent(
                        title: "Book",
                        subtitle: "Tap the button",
                        description: "Our selection of honeymoon resorts is perfect setting for you to embark your new life together.",
                        icon: "checkmark.square"
                    )
                } //: VSTACK
                
                Spacer(minLength: 10)
                
                Button {
                    dismiss()
                } label: {
                    Text("Continue".uppercased())
                        .modifier(ButtonModifier())
                } //: BUTTON
            } //: VSTACK
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        } //: SCROLL
    }
}

struct GuidView_Previews: PreviewProvider {
    static var previews: some View {
        GuidView()
    }
}
