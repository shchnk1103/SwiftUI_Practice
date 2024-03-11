//
//  AVPlayerTestView.swift
//  DDOY
//
//  Created by DoubleShy0N on 2023/10/24.
//

import SwiftUI
import AVKit

struct AVPlayerTestView: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "video", withExtension: "mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .frame(width: 320, height: 180, alignment: .center)
            .onAppear(perform: {
                print(Bundle.main.url(forResource: "video", withExtension: "mp4")!)
            })
    }
}

#Preview {
    AVPlayerTestView()
}
