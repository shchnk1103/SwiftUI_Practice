//
//  CheckInRow.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/7.
//

import SwiftUI
import SwipeActions

struct CheckInRow: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: HomeViewModel
    
    @Binding var showingAlert: Bool
    @Binding var wantToCheckin: Bool
    
    @ObservedObject var checkin: CheckIn
    
    var body: some View {
        SwipeView {
            // Content
            HStack {
                roundedRectangle
                
                content
            }
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .strokeStyle(cornerRadius: 8)
            // pin heart
            .overlay {
                if checkin.isPinned {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .position(x: 0, y: 0)
                }
            }
        } leadingActions: { context in
            SwipeAction(systemImage: "flag.checkered.circle", backgroundColor: .cyan) {
                context.state.wrappedValue = .closed
                wantToCheckin = true
                vm.selectedCheckIn = checkin
            }
            .allowSwipeToTrigger()
            .font(.title)
            .foregroundColor(.white)
        } trailingActions: { context in
            SwipeAction(systemImage: "trash", backgroundColor: .red) {
                context.state.wrappedValue = .closed
                showingAlert = true
                vm.selectedCheckIn = checkin
            }
            .allowSwipeToTrigger()
            .font(.title)
            .foregroundColor(.white)
        }
        .swipeActionCornerRadius(8)
    }
    
    var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(
                colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5),
                lineWidth: 1
            )
            .frame(width: 60, height: 60)
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .overlay {
                Text(checkin.emojiText ?? "🥰")
                    .font(.largeTitle)
            }
            .padding(10)
    }
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("坚持 ")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text(checkin.name ?? "")
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                HStack(alignment: .center, spacing: 0) {
                    Text("已经 ")
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text("\(checkin.persistDay)/\(checkin.targetDate ?? "")")
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
}

//struct CheckInRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInRow(showingAlert: .constant(false), wantToCheckin: .constant(false), checkin: <#CheckIn#>)
//    }
//}
