//
//  VideoListView.swift
//  Africa
//
//  Created by 沈晨凯 on 2022/11/11.
//

import SwiftUI

struct VideoListView: View {
    @State var videos: [Video] = Bundle.main.decode("videos.json")
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(videos) { video in
                    NavigationLink(destination: {
                        VideoPlayerView(videoSelected: video.id, videoTitle: video.name)
                    }, label: {
                        VideoListItemView(video: video)
                            .padding(.vertical, 8)
                    })
                } //: LOOP
            } //: LIST
            .listStyle(.insetGrouped)
            .navigationTitle("Videos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        videos.shuffle()
                        hapticImpact.impactOccurred()
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                    }

                }
            }
        }) //: NAVIGATION
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
