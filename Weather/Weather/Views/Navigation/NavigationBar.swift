//
//  NavigationBar.swift
//  Weather
//
//  Created by DoubleShy0N on 2022/12/23.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // MARK: - Back Button
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 5) {
                        // MARK: - Back Button Icon
                        Image(systemName: "chevron.left")
                            .foregroundColor(.secondary)
                            .font(.system(size: 23, weight: .medium))
                        
                        // MARK: - Back Button Label
                        Text("Weather")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    .frame(height: 44)
                }
                
                Spacer()
                
                // MARK: - More Button
                Image(systemName: "ellipsis.circle")
                    .frame(width: 44, height: 44, alignment: .trailing)
                    .font(.system(size: 28))
            }
            .frame(height: 52)
            
            // MARK: - Search Bar
            HStack(spacing: 2) {
                Image(systemName: "magnifyingglass")
                
                TextField(text: $searchText) {
                    Text("Search for a city")
                }
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, 6)
            .padding(.vertical, 7)
            .frame(height: 36, alignment: .leading)
            .background(
                Color.bottomSheetBackground,
                in: RoundedRectangle(cornerRadius: 10)
            )
            .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .black.opacity(0.25), lineWidth: 2, offsetX: 0, offsetY: 2, blur: 2)
        }
        .frame(height: 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 49)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(searchText: .constant(""))
    }
}
