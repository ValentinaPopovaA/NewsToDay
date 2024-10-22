//
//  SceneDelegate.swift
//  NewsToDay
//
//  Created by Валентина Попова on 20.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootViewController = FavoritesViewController()
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

