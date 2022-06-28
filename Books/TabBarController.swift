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
        let viewControllers = [self.firstTabViewController, self.secondTabViewController]
        
        self.viewControllers = viewControllers
        
        self.selectedIndex = 0
    }
    
    func configureTabBar() {
        self.tabBar.backgroundColor = .systemGroupedBackground
    }
    
    func configureTabBarItem() {
        self.firstTabViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "book"), tag: 0)
        
        self.secondTabViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    }
}
