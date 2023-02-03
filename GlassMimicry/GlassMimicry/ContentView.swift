//
//  ContentView.swift
//  GlassMimicry
//
//  Created by DoubleShy0N on 2023/1/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
                .opacity(0.6)
                .background(.thinMaterial)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Image("Icon")
                        .frame(width: 44, height: 44)
                    
                    Text("下午好，DoubleShy0N")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.bottom, 32)
                
                VStack(alignment: .leading, spacing: 32) {
                    HStack {
                        Text("搜索")
                            .font(.body)
                        
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                    .foregroundColor(.secondary)
                    .frame(height: 44)
                    .boxShadowStyle()
                    
                    VStack(alignment:.leading, spacing: 20) {
                        Text("按分类搜索")
                            .font(.body)
                            .fontWeight(.semibold)
                        
                        Text("UI/UX 设计师")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(Color("ColorSelected"))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .boxShadowStyle(cornerRadius: 24)
                    }
                }
            }
            .padding(20)
        }
        .background(
            Image("Background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
