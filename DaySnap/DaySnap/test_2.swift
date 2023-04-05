//
//  test_2.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/5.
//

import SwiftUI

struct test_2: View {
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: []) var countdowns: FetchedResults<CountDown>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            List(countdowns) { countdown in
                HStack {
                    Text(countdown.emojiText ?? "🥰")
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            Text("距离")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(countdown.name ?? "")
                            .font(.body)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            Text(countdown.remainingDays > 0 ? "还有 " : "已经 ")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(String(abs(countdown.remainingDays)))
                                .font(.title)
                                .fontWeight(.semibold)
                            Text(" 天")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "ellipsis.circle")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                }
            }
            
            Button {
                let countdown = CountDown(context: moc)
                countdown.id = UUID()
                countdown.name = "ss"
                
                try? moc.save()
            } label: {
                Text("Add")
            }

        }
    }
}

struct test_2_Previews: PreviewProvider {
    static let countdownStore = CountdownStore()
    static let checkinStore = CheckinStore()
    
    static var previews: some View {
        test_2()
            .environmentObject(countdownStore)
            .environmentObject(checkinStore)
    }
}
