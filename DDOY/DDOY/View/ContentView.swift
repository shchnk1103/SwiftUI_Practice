//
//  ContentView.swift
//  DDOY
//
//  Created by DoubleShy0N on 2023/10/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var showFileImporter: Bool = false
    @State private var selectedVideoURL: URL?
    @State private var selectedVideoName: String = "ERROR!"
    
    var body: some View {
        VStack {
            if let url = selectedVideoURL {
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200, alignment: .center)
            }
            
            Text(selectedVideoName)
                .font(.title.bold())
                .foregroundStyle(.blue.gradient)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
            
            Button("Import") {
                 showFileImporter = true
            }
            .fileImporter(
                isPresented: $showFileImporter, 
                allowedContentTypes: [.movie]
            ) { result in
                switch result {
                case .success(let directory):
                    // gain access to the directory
                    let gotAccesee = directory.startAccessingSecurityScopedResource()
                    if !gotAccesee { return }
                    
                    // access the directory URL
                    let directoryURL = directory.absoluteURL
                    if directoryURL.startAccessingSecurityScopedResource() {
                        selectedVideoURL = directoryURL
                    } else {
                        return
                    }

                    // get the video file name
                    if let videoName = directory.pathComponents.last {
                        selectedVideoName = videoName
                    }
                    
                    directory.stopAccessingSecurityScopedResource()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
