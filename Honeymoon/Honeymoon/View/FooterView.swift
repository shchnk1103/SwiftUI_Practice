//
//  FooterView.swift
//  Honeymoon
//
//  Created by DoubleShy0N on 2022/12/12.
//

import SwiftUI

struct FooterView: View {
    // MARK: - PROPERTY
    @Binding var showBookingAlert: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 24, weight: .light))
            
            Spacer()
            
            Button {
                haptics.notificationOccurred(.success)
                playSound(sound: "sound-click", type: "mp3")
                showBookingAlert.toggle()
            } label: {
                Text("Book Destination".uppercased())
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .tint(Color.pink)
                    .background {
                        Capsule()
                            .stroke(Color.pink, lineWidth: 2)
                    }
            }
            
            Spacer()
            
            Image(systemName: "heart.circle")
                .font(.system(size: 24, weight: .light))
        } //: HSTACK
        .padding()
    }
}

// MARK: - PREVIEW
struct FooterView_Previews: PreviewProvider {
    @State static var showAlert: Bool = false
    
    static var previews: some View {
        FooterView(showBookingAlert: $showAlert)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
