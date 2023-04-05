//
//  test_1.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/4.
//

import SwiftUI

struct test_1: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        VStack {
            Button("获取权限") {
                notificationManager.requestAuthorization()
            }
            
            Button(action: {
                // notificationManager.sendNotification()
            }) {
                Text("发送通知")
            }
            
            Button(action: {
                notificationManager.getNotificationHistory()
            }) {
                Text("获取通知历史记录")
            }
            
            List {
                ForEach(notificationManager.notifications, id: \.self) { notification in
                    Text("\(notification.request.content.title)")
                }
            }
        }
    }
}

struct test_1_Previews: PreviewProvider {
    static let notificationManager = NotificationManager()
    
    static var previews: some View {
        test_1()
            .environmentObject(notificationManager)
    }
}
