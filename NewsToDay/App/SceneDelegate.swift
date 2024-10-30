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

        // MARK: -  Принудительный выход при включении
        AuthService.shared.signOut { result in
            switch result {
            case .success():
                print("Успешный выход")
            case .failure(let error):
                print("Ошибка выхода: \(error.localizedDescription)")
            }
        }
        
        var rootViewController = UIViewController()
        
        if AuthService.shared.isSignedIn() {
            print("Пользователь был авторизован до этого")
            rootViewController = MainViewController()
        } else {
            rootViewController = LoginViewController()
            print("Пользователь не был авторизован до этого")
        }
        
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

