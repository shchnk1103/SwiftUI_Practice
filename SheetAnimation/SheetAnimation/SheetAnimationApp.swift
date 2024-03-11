//
//  SheetAnimationApp.swift
//  SheetAnimation
//
//  Created by DoubleShy0N on 2023/10/13.
//

import SwiftUI

@main
struct SheetAnimationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    var windowSharedModel = WindowSharedModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(windowSharedModel)
        }
    }
}

/// App Delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        
        return config
    }
}

/// Scene Delegate
@Observable
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    weak var windowScene: UIWindowScene?
    
    var heroWindow: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        windowScene = scene as? UIWindowScene
    }
    
    func addHeroWindow(_ windowSharedModel: WindowSharedModel) {
        guard let scene = windowScene else { return }
        
        let heroWindowController = UIHostingController(
            rootView: CustomHeroAnimationView()
                        .environment(windowSharedModel)
                        .allowsHitTesting(false)
        )
        heroWindowController.view.backgroundColor = .clear
        let heroWindow = UIWindow(windowScene: scene)
        heroWindow.rootViewController = heroWindowController
        heroWindow.isHidden = false
        heroWindow.isUserInteractionEnabled = false
        
        self.heroWindow = heroWindow
    }
}

struct CustomHeroAnimationView: View {
    @Environment(WindowSharedModel.self) private var windowSharedModel
    
    var body: some View {
        Text("")
    }
}
