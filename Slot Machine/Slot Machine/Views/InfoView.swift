//
//  InfoView.swift
//  Slot Machine
//
//  Created by 沈晨凯 on 2022/12/3.
//

import SwiftUI

struct InfoView: View {
  // MARK: - PROPERTY
  @Environment(\.dismiss) var dismiss
  
  // MARK: - BODY
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      LogoView()
      
      Spacer()
      
      Form {
        Section {
          FormRowView(firstItem: "Application", secondItem: "Slot Machine")
          FormRowView(firstItem: "Platform", secondItem: "iPhone, iPad, Mac")
          FormRowView(firstItem: "Developer", secondItem: "John / Jane")
          FormRowView(firstItem: "Designer", secondItem: "Robert Petras")
          FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
          FormRowView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
          FormRowView(firstItem: "Copyright", secondItem: "Ⓒ 2022 All right reserved")
          FormRowView(firstItem: "Version", secondItem: "1.0.0")
        } header: {
          Text("About the application")
        } //: SECTION
      } //: FORM
      .font(.system(.body, design: .rounded))
    } //: VTSACK
    .padding(.top, 40)
    .overlay(alignment: .topTrailing) {
      Button {
        audioPlayer?.stop()
        dismiss.callAsFunction()
      } label: {
        Image(systemName: "xmark.circle")
          .font(.title)
      }
      .accentColor(.secondary)
      .padding(.top, 30)
      .padding(.trailing, 20)
      .onAppear {
        playSound(sound: "background-music", type: "mp3")
      }
    } //: OVERLAY
  }
}

struct FormRowView: View {
  // MARK: - Property
  var firstItem: String
  var secondItem: String
  
  // MARK: - BODY
  var body: some View {
    HStack {
      Text(firstItem).foregroundColor(.gray)
      Spacer()
      Text(secondItem)
    }
  }
}

// MARK: - PREVIEW
struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
  }
}

