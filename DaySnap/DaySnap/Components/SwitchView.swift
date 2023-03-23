//
//  SwitchView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI

struct SwitchView: View {
    @EnvironmentObject var countdownStore: CountdownStore
    @EnvironmentObject var checkinStore: CheckinStore
    @Binding var isCountdownButtonClicked: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            countdownButton
            
            checkinButton
        }
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
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
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
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0)
    }
}

struct SwitchView_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        SwitchView(isCountdownButtonClicked: .constant(true))
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
    }
}
