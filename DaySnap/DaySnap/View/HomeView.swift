//
//  HomeView.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/3/11.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("flag") var flag: Bool = true
    
    @StateObject private var vm = HomeViewModel()
    @StateObject private var filter = CountDownFilter()
    @StateObject private var filterCheckin = CheckInFilter()
    
    @State private var wantToCheckin: Bool = false
    @State private var showingAlert: Bool = false
    @State private var showAttribution: Bool = false
    
    @State private var offset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var scrollPaddingTop: CGFloat = 0
    @State private var switchOffset: CGFloat = 0
    @State private var switchHeight: CGFloat = 0
    @State private var textHeight: CGFloat = 0
    @State private var selectedCategory: Int = 0
    @State private var selectedStatus: Int = 0
    
    var body: some View {
        ZStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 0) {
                
                header
                
                switchCenter
            }
            .zIndex(1)
            .padding(.bottom, offset < switchHeight ? -offset : -(switchHeight + textHeight - 15))
            .background(.regularMaterial)
            .shadow(radius: 4)
            // GeometryReader
            .overlay { overlay }
            
            // MARK: Content
            ScrollView(.vertical, showsIndicators: false) {
                itemList
            }
            
            // 弹窗提醒 - 打卡
            if wantToCheckin {
                ToCheckinView(flag: $wantToCheckin)
                    .zIndex(2)
                    .environmentObject(vm)
            }
            
            // 弹窗提醒 - 删除
            if showingAlert {
                DeleteView(showingAlert: $showingAlert)
                    .environmentObject(vm)
            }
            
            // 弹窗提醒 -  天气归属
            if showAttribution {
                WeatherAttributionView(showAttribution: $showAttribution)
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UIScrollView.appearance().backgroundColor = .clear
        }
        .onAppear {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "categories"),
               let decoded = try? decoder.decode([Category].self, from: data) {
                categories = decoded
            }
        }
    }
    
    var header: some View {
        HeaderView(showAttribution: $showAttribution)
            .padding(.horizontal)
            .background(colorScheme == .dark ? .black : .white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(colorScheme == .dark ? .white.opacity(0.5) : .white, lineWidth: 1)
            }
            .shadow(
                color: colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.25),
                radius: 12, x: 0, y: 0
            )
            .padding()
            .offset(getOffset())
            .opacity(getOpacity())
            // GeometryReader
            .overlay {
                GeometryReader { geo -> Color in
                    let maxY = geo.frame(in: .global).maxY
                    
                    DispatchQueue.main.async {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            let window = UIWindow(windowScene: windowScene)
                            let safeAreaInsets = window.safeAreaInsets.top
                            switchOffset = maxY - safeAreaInsets
                        }
                    }
                    
                    return Color.clear
                }
            }
    }
    
    var switchCenter: some View {
        VStack(alignment: .leading, spacing: 0) {
            SwitchView()
                .padding()
                .frame(height: 60)
                .offset(y: offset > 0 ? (offset <= switchOffset ? -offset : -switchOffset) : 0)
            
            pickers
        }
        // GeometryReader
        .overlay {
            GeometryReader { geo -> Color in
                let height = geo.size.height
                
                DispatchQueue.main.async {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
                        let safeAreaInsets = window.safeAreaInsets.top
                        switchHeight = height + safeAreaInsets
                    }
                }
                
                return Color.clear
            }
        }
    }
    
    var pickers: some View {
        HStack {
            Text(flag ? "所有倒数日" : "所有打卡项目")
            
            Spacer()
            
            if flag {
                if !categories.isEmpty {
                    Picker(selection: $selectedCategory) {
                        ForEach(categories, id: \.id) { category in
                            HStack {
                                Image(systemName: category.icon)
                            }
                            .tag(category.id)
                        }
                    } label: {
                        HStack {
                            Text(categories[selectedCategory].name)
                            Image(systemName: categories[selectedCategory].icon)
                        }
                    }
                    .frame(height: 35)
                    .onChange(of: selectedCategory) { newValue in
                        filter.category = categories[newValue].name
                    }
                }
            } else {
                Picker(selection: $selectedStatus) {
                    ForEach(statuses, id: \.id) { status in
                        Text(status.name).tag(status.id)
                    }
                } label: {
                    HStack {
                        Text(statuses[selectedStatus].name)
                    }
                }
                .frame(height: 35)
                .onChange(of: selectedStatus) { newValue in
                    filterCheckin.status = statuses[selectedStatus].name
                }
            }
        }
        .frame(height: 8)
        .font(.body)
        .foregroundColor(.secondary)
        .padding()
        .offset(y: offset > 0 ? (offset <= switchOffset ? -offset : -switchOffset) : 0)
        .opacity(getOpacity())
        .animation(.easeOut, value: flag)
        .overlay {
            GeometryReader { geo -> Color in
                let height = geo.size.height
                
                DispatchQueue.main.async {
                    textHeight = height
                }
                
                return Color.clear
            }
        }
        .animation(.default, value: selectedCategory)
    }
    
    var overlay: some View {
        GeometryReader { geo -> Color in
            let height = geo.size.height
            
            DispatchQueue.main.async {
                if scrollPaddingTop == 0 {
                    scrollPaddingTop = height
                }
            }
            
            return Color.clear
        }
    }
    
    var itemList: some View {
        ItemListView(wantToCheckin: $wantToCheckin, showingAlert: $showingAlert)
            .environmentObject(vm)
            .environmentObject(filter)
            .environmentObject(filterCheckin)
            .frame(maxHeight: .infinity)
            .padding(.top, scrollPaddingTop)
            // GeometryReader
            .overlay(alignment: .top) {
                GeometryReader { geo -> Color in
                    let minY = geo.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        if startOffset == 0 {
                            startOffset = minY
                        }
                        
                        offset = startOffset - minY
                    }
                    
                    return Color.clear
                }
                .frame(width: 0, height: 0)
            }
    }
    
    
    // MARK: fuctions
    
    private func getOffset() -> CGSize {
        var size: CGSize = .zero
        size.width = 0
        size.height = offset > 0 ? -offset : 0
        
        return size
    }
    
    private func getOpacity() -> Double {
        var opacity: Double = 0
        
        if offset > 0 {
            opacity = 1.0 - min(abs(getOffset().height / 100), 1.0)
        } else if offset > 120 {
            opacity = 0
        } else {
            opacity = 1
        }
        
        return opacity
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
