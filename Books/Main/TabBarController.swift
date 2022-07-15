import UIKit
import RxCocoa
import RxSwift

class TabBarController: UITabBarController {
    
    lazy var showNewBooksViewController = ShowNewBooksViewController()
    
    lazy var searchBooksViewController = SearchBooksViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureContentViewControllers()

        self.configureTabBar()

        self.configureTabBarItem()
    }
    
    func configureContentViewControllers() {
        let showNewBooksNavigationController = UINavigationController(rootViewController: self.showNewBooksViewController)
        
        let searchBooksNavigationController = UINavigationController(rootViewController: self.searchBooksViewController)
        
        let viewControllers = [showNewBooksNavigationController, searchBooksNavigationController]
        
        self.viewControllers = viewControllers
        
        self.selectedIndex = 0
    }
    
    func configureTabBar() {
        self.tabBar.backgroundColor = .systemGroupedBackground
        self.tabBar.isTranslucent = true
    }
    
    func configureTabBarItem() {
        self.showNewBooksViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "book"), tag: 0)
        
        self.searchBooksViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    }
}
