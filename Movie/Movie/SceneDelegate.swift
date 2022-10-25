//
//  SceneDelegate.swift
//  Movie
//
//  Created by Дмитрий Супрун on 25.10.22.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = MovieListViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
