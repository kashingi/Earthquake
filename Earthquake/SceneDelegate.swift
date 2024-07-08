

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Example Earthquake object (replace with your actual earthquake data)
        let exampleEarthquake = Earthquake(place: "San Francisco", magnitude: 4.5, latitude: 37.7749, longitude: -122.4194)
        
        let earthquakeTableViewController = EarthquakeTableViewController()
        earthquakeTableViewController.tabBarItem = UITabBarItem(title: "Earthquakes", image: UIImage(systemName: "list.dash"), tag: 0)
        
        let earthquakeMapViewController = EarthquakeMapViewController(earthquake: exampleEarthquake)
        earthquakeMapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [earthquakeTableViewController, earthquakeMapViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    // Other lifecycle methods can remain unchanged
}

