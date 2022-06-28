import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        
        let tabBarController = TabBarController()

        self.window?.rootViewController = tabBarController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

