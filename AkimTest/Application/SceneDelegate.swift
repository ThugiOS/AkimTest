//
//  SceneDelegate.swift
//  AkimTest
//
//  Created by Никитин Артем on 15.05.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let lastShownPaywall = Settings.getLastShownPaywall()
        
        switch lastShownPaywall {
        case .first:
            window?.rootViewController = SecondPaywallViewController()
        case .second:
            window?.rootViewController = FirstPaywallViewController()
        }
        
        window?.makeKeyAndVisible()
    }
}


