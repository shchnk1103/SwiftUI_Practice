//
//  SwitchView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct SwitchView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @AppStorage("flag") var isCountdownButtonClicked: Bool = true
    
    var body: some View {
        HStack(spacing: 10) {
            countdownButton
            
            checkinButton
        }
        .animation(.default, value: isCountdownButtonClicked)
    }
    
    var countdownButton: some View {
        Button {
            isCountdownButtonClicked = true
        } label: {
            HStack {
                Spacer()
                Text("\(countdownStore.countdowns.count)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()
                Text("倒数日")
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer()
            }
            .foregroundColor(isCountdownButtonClicked ? .white : .black.opacity(0.5))
            .padding(.vertical, 8)
        }
        .background(isCountdownButtonClicked ? .black : .white)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(colorScheme == .dark ? .white.opacity(0.5) : .gray.opacity(0.8), lineWidth: 1)
                .blendMode(.overlay)
        }
        .shadow(color: colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.25), radius: 4, x: 0, y: 0)
    }
    
    var checkinButton: some View {
        Button {
            isCountdownButtonClicked = false
        } label: {
            HStack {
                Spacer()
                Text("\(checkinStore.checkins.count)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()
                Text("打卡")
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer()
            }
            .foregroundColor(isCountdownButtonClicked ? .black.opacity(0.5) : .white)
            .padding(.vertical, 8)
        }
        .background(isCountdownButtonClicked ? .white : .black)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(colorScheme == .dark ? .white.opacity(0.5) : .gray.opacity(0.8), lineWidth: 1)
                .blendMode(.overlay)
        }
        .shadow(color: colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.25), radius: 4, x: 0, y: 0)
    }
}

struct SwitchView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        SwitchView()
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
    }
}
