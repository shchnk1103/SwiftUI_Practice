//
//  SettingLabelView.swift
//  Fructus
//
//  Created by 沈晨凯 on 2022/11/10.
//

import SwiftUI

struct SettingLabelView: View {
    // MARK: - PROPERTIES
    var labelText: String
    var labelImage: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(labelText.uppercased())
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: labelImage)
        }
    }
}

// MARK: - PREVIEW
struct SettingLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingLabelView(labelText: "Frutus", labelImage: "info.circle")
            .padding()
    }
}
