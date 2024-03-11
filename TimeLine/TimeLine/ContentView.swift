//
//  ContentView.swift
//  TimeLine
//
//  Created by DoubleShy0N on 2024/3/10.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [TDModel] = [
        TDModel(title: "Wake Up!", isCompleted: false),
        TDModel(title: "Eat Breakfast", isCompleted: false),
        TDModel(title: "Do Some Sports", isCompleted: false),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { item in
                    HStack {
                        Image(systemName: items[item].isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(items[item].isCompleted ? .green : .primary)
                        
                        Text(items[item].title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                            .strikethrough(items[item].isCompleted)
                            .animation(.none, value: items[item].isCompleted)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(items[item].isCompleted ? .green.opacity(0.6) : .yellow)
                                    .frame(height: 80)
                            }
                        
                        Spacer()
                    }
                    .font(.title2)
                    .overlay(alignment: .topLeading) {
                        Rectangle()
                            .frame(width: 1, height: items[item].isCompleted ? 68 : 0)
                            .offset(y: 24)
                            .padding(.leading, 12)
                    }
                    .frame(height: 90)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation {
                            items[item].isCompleted.toggle()
                        }
                    }
                }
                
                HStack {
                    Image(systemName: items.allSatisfy({ $0.isCompleted }) ? "checkmark.circle.fill" : "circle")
                    
                    Text(items.allSatisfy({ $0.isCompleted }) ? "Done" : "Finish")
                        .padding()
                        .foregroundStyle(items.allSatisfy({ $0.isCompleted }) ? .white : .gray)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(items.allSatisfy({ $0.isCompleted }) ? .green.opacity(0.6) : .red.opacity(0.6))
                        }
                    
                    Spacer()
                }
                .foregroundStyle(items.allSatisfy({ $0.isCompleted }) ? .green : .gray)
                .font(.title2)
                .frame(height: 90)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    toggleItems()
                }
            }
            .padding(.vertical)
        }
    }
    
    func toggleItems() {
        let allTrue = items.allSatisfy({ $0.isCompleted })
        
        updateItemSequentially(makeTrue: !allTrue, revers: allTrue)
    }
    
    func updateItemSequentially(makeTrue: Bool, revers: Bool) {
        let delayStep = 0.5
        let indices = revers ? Array(items.indices.reversed()) : Array(items.indices)
        
        for (offset, item) in indices.enumerated() {
            let delay = delayStep * Double(offset)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    items[item].isCompleted = makeTrue
                }
            }
        }
    }
}

struct TDModel: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}

#Preview {
    ContentView()
}
