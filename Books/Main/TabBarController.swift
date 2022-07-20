import UIKit
import RxCocoa
import RxSwift

class TabBarController: UITabBarController {
    
    lazy var newBookViewController = NewBookViewController()
    
    lazy var searchBooksViewController = SearchBooksViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureContentViewControllers()

        self.configureTabBar()

        self.configureTabBarItem()
    }
    
    func configureContentViewControllers() {
        let newBookViewController = UINavigationController(rootViewController: self.newBookViewController)
        
        let searchBooksNavigationController = UINavigationController(rootViewController: self.searchBooksViewController)
        
        let viewControllers = [newBookViewController, searchBooksNavigationController]
        
        self.viewControllers = viewControllers
        
        self.selectedIndex = 0
    }
    
    func configureTabBar() {
        self.tabBar.backgroundColor = .systemGroupedBackground
        self.tabBar.isTranslucent = true
    }
    
    func configureTabBarItem() {
        self.newBookViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "book"), tag: 0)
        
        self.searchBooksViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    }
}
