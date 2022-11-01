//
//  SceneDelegate.swift
//  Movie
//
//  Created by Дмитрий Супрун on 25.10.22.
//

import UIKit

/// SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties
    let viewController = MovieListViewController()
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    // MARK: - Public Methods
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
