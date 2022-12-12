//
//  HeaderView.swift
//  Honeymoon
//
//  Created by DoubleShy0N on 2022/12/12.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTY
    @Binding var showGuideView: Bool
    @Binding var showInfoView: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Button {
                haptics.notificationOccurred(.success)
                playSound(sound: "sound-click", type: "mp3")
                showInfoView.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .tint(.primary)
            .sheet(isPresented: $showInfoView) {
                InfoView()
            }
            
            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button {
                haptics.notificationOccurred(.success)
                playSound(sound: "sound-click", type: "mp3")
                showGuideView.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .tint(.primary)
            .sheet(isPresented: $showGuideView) {
                GuidView()
            }
        } //: HSTACK
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuid: Bool = false
    @State static var showInfo: Bool = false
    
    static var previews: some View {
        HeaderView(showGuideView: $showGuid, showInfoView: $showInfo)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
