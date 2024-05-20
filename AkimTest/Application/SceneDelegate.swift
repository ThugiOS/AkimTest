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
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = FirstPaywallViewController()
//        window.rootViewController = SecondPaywallViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

