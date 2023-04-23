//
//  CountDownRow.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/7.
//

import SwiftUI
import SwipeActions

struct CountDownRow: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    
    @State private var swipeOffset: CGFloat = 0
    @Binding var showingAlert: Bool
    
    @ObservedObject var countdown: CountDown
    
    var body: some View {
        SwipeView {
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(
                        colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5),
                        lineWidth: 1
                    )
                    .frame(width: 60, height: 60)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .overlay {
                        Text(countdown.emojiText ?? "🥰")
                            .font(.largeTitle)
                    }
                    .padding(10)

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text(countdown.remainingDays == 0 ? "" : "距离 ")
                            .font(.body)
                            .foregroundColor(.secondary)

                        if countdown.remainingDays == 0 {
                            if #available(iOS 16.0, *) {
                                Image(systemName: "laurel.leading")
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 3)
                                
                                Text(countdown.name ?? "")
                                    .font(.body)

                                Image(systemName: "laurel.trailing")
                                    .fontWeight(.semibold)
                                    .padding(.leading, 3)
                            } else {
                                Image(systemName: "laurel.leading")
                                    .padding(.trailing, 3)
                                
                                Text(countdown.name ?? "")
                                    .font(.body)

                                Image(systemName: "laurel.trailing")
                                    .padding(.leading, 3)
                            }
                        } else {
                            Text(countdown.name ?? "")
                                .font(.body)
                        }
                    }

                    HStack(spacing: 0) {
                        Text(countdown.remainingDays > 0
                             ? "还有 "
                             : (countdown.remainingDays == 0 ? "就是今天" : "已经 ")
                        )
                        .font(.body)
                        .foregroundColor(.secondary)

                        if countdown.remainingDays != 0 {
                            Text(String(abs(countdown.remainingDays)))
                                .font(.title)
                                .fontWeight(.semibold)

                            Text(" 天")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "ellipsis.circle")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .strokeStyle(cornerRadius: 8)
            // pin heart
            .overlay {
                if countdown.isPinned {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .position(x: 0, y: 0)
                }
            }
        } trailingActions: { context in
            SwipeAction(systemImage: "trash", backgroundColor: .red) {
                context.state.wrappedValue = .closed
                showingAlert = true
                vm.selectedCountdown = countdown
            }
            .allowSwipeToTrigger()
            .font(.title)
            .foregroundColor(.white)
        }
        .swipeActionCornerRadius(8)
    }
}

//struct CountDownRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CountDownRow(countdown: CountDown())
//    }
//}
