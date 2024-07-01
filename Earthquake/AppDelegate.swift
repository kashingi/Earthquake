import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create the main window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create instances of the view controllers
        let earthquakeTableViewController = EarthquakeTableViewController()
        earthquakeTableViewController.tabBarItem = UITabBarItem(title: "Earthquakes", image: UIImage(systemName: "list.dash"), tag: 0)
        
        let earthquakeMapViewController = EarthquakeMapViewController()
        earthquakeMapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        
        // Create a tab bar controller and add the view controllers
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [earthquakeTableViewController, earthquakeMapViewController]
        
        // Set the root view controller to the tab bar controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
