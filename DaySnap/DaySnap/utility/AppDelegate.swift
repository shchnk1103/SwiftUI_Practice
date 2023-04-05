//
//  AppDelegate.swift
//  DaySnap
//
//  Created by DoubleShy0N on 2023/4/4.
//

//import SwiftUI
//import UserNotifications
//import CoreData
//
//// 设置 Notification 代理
//class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        // 设置 Notification 代理为 AppDelegate
//        UNUserNotificationCenter.current().delegate = self
//        
//        // 前台弹出通知的展示方式
//        // UNUserNotificationCenter.current().presentationOptions = [.badge, .sound, .alert]
//        
//        return true
//    }
//    
//    // 在前台收到通知的展示方式
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.banner, .badge, .sound])
//    }
//}
