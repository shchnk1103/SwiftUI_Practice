//
//  Home.swift
//  NavigationStackAnimation
//
//  Created by DoubleShy0N on 2023/7/24.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    
    var body: some View {
        List {
            ForEach(profiles) { profile in
                Button(action: {
                    selectedProfile = profile
                    pushView.toggle()
                }, label: {
                    HStack(spacing: 15, content: {
                        Color.clear
                            .frame(width: 60, height: 60)
                            /// Source View Anchor
                            .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                                return [profile.id: anchor]
                            })
                        
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    })
                    .contentShape(.rect)
                })
            }
        }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                ForEach(profiles) { profile in
                    /// Fetching Each Profile Image View using the Profile ID
                    /// Hiding the Currently Tapped View
                    if let anchor = value[profile.id], selectedProfile?.id != profile.id {
                        let rect = geometry[anchor]
                        
                        ImageView(profile: profile, size: rect.size)
                            .offset(x: rect.minX, y: rect.minY)
                            .allowsHitTesting(false)
                    }
                }
            })
        })
    }
}

struct ImageView: View {
    var profile: Profile
    var size: CGSize
    
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            /// Linear Gradient at Bottom
            .overlay(content: {
                LinearGradient(colors: [
                    .clear,
                    .clear,
                    .clear,
                    .white.opacity(0.1),
                    .white.opacity(0.5),
                    .white.opacity(0.9),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .opacity(size.width > 60 ? 1 : 0)
            })
            .clipShape(.rect(cornerRadius: size.width > 60 ? 0 : 30))
    }
}

#Preview {
    ContentView()
}
