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
            ForEach(0..<5) { _ in
                Image(systemName: "trash")
                    .padding()
            }
            
            NavigationStack {
                List {
                    ForEach(countdowns, id: \.self) { countdown in
                        NavigationLink(value: countdown) {
                            Text(countdown.name ?? "")
                        }
                    }
                    .navigationDestination(for: CountDown.self, destination: { countdown in
                        EmptyView()
                            .edgesIgnoringSafeArea(.all)
                    })
                    .swipeActions {
                        Button {
                            
                        } label: {
                            Image(systemName: "trash")
                        }

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
