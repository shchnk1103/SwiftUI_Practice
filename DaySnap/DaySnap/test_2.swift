//
//  test_2.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI

struct test_2: View {
    @State private var downloadProgress: Double = 0.0
    
    var body: some View {
        VStack {
            ProgressView("Downloading...", value: downloadProgress, total: 100.0)
                .padding(50)
            
            Button("Download") {
                // 在这里模拟下载进程
                for i in 0...100 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50 * i)) {
                        downloadProgress = Double(i)
                    }
                }
            }
        }
    }
}

struct test_2_Previews: PreviewProvider {
    static var previews: some View {
        test_2()
    }
}
