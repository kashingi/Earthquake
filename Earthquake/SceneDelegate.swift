//
//  SceneDelegate.swift
//  Earthquake
//
//  Created by EMTECH MAC on 19/06/2024.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let earthquakeTableViewController = EarthquakeTableViewController()
        earthquakeTableViewController.tabBarItem = UITabBarItem(title: "Earthquakes", image: UIImage(systemName: "list.dash"), tag: 0)
        
        let earthquakeMapViewController = EarthquakeMapViewController()
        earthquakeMapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [earthquakeTableViewController, earthquakeMapViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    // Other lifecycle methods can remain unchanged
}
