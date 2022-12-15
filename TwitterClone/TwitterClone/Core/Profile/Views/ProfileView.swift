//
//  ProfileView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/14.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Namespace var animation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: 12)
                }

                
                Circle()
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 36)
            }
        }
        .frame(height: 96)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay {
                    Circle().stroke(Color.gray, lineWidth: 0.75)
                }
            
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(.black)
                    .overlay {
                        Capsule().stroke(Color.gray, lineWidth: 0.75)
                    }
            }
        }
        .padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Heath Ledger")
                    .font(.title2)
                    .bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            
            Text("@Joker")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Your moms favorite villain")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("Gotham, NY")
                }
                
                HStack {
                    Image(systemName: "link")
                    
                    Text("www.joker.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            UserStatsView()
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay {
            Divider()
                .offset(x: 0, y: 16)
        }
    }
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ... 9, id: \.self) { _ in
                    TweetRowView()
                        .padding()
                }
            }
        }
    }
}
