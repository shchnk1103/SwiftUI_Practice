//
//  SideMenuRowView.swift
//  TwitterClone
//
//  Created by DoubleShy0N on 2022/12/15.
//

import SwiftUI

struct SideMenuRowView: View {
    let viewModel: SideMenuVIewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(viewModel.title)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuRowView(viewModel: SideMenuVIewModel.profile)
    }
}
