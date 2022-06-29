import UIKit

class TabBarController: UITabBarController {
    
    let firstTabViewController = ShowNewBooksViewController()
    
    let secondTabViewController = SearchBooksViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureContentViewControllers()
        
        self.configureTabBar()
        
        self.configureTabBarItem()
    }
    
    func configureContentViewControllers() {
        let showNewBooksNavigationController = UINavigationController(rootViewController: self.firstTabViewController)
        
        let searchBooksNavigationController = UINavigationController(rootViewController: self.secondTabViewController)
        
        let viewControllers = [showNewBooksNavigationController as UIViewController, searchBooksNavigationController as UIViewController]
        
        self.viewControllers = viewControllers
        
        self.selectedIndex = 0
    }
    
    func configureTabBar() {
        self.tabBar.backgroundColor = .systemGroupedBackground
        self.tabBar.isTranslucent = true
    }
    
    func configureTabBarItem() {
        self.firstTabViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "book"), tag: 0)
        
        self.secondTabViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    }
}
