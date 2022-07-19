import UIKit
import RxCocoa
import RxSwift

class TabBarController: UITabBarController {
    
    lazy var showNewBooksViewController = ShowNewBooksViewController()
    
    lazy var mvvm_ShowNewBooksViewController = MVVM_ShowNewBooksViewController()
    
    lazy var searchBooksViewController = SearchBooksViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureContentViewControllers()

        self.configureTabBar()

        self.configureTabBarItem()
    }
    
    func configureContentViewControllers() {
        let mvvm_showNewBooksNavigationController = UINavigationController(rootViewController: self.mvvm_ShowNewBooksViewController)
        
        let showNewBooksNavigationController = UINavigationController(rootViewController: self.showNewBooksViewController)
        
        let searchBooksNavigationController = UINavigationController(rootViewController: self.searchBooksViewController)
        
//        let viewControllers = [showNewBooksNavigationController, searchBooksNavigationController]
        let viewControllers = [mvvm_ShowNewBooksViewController, searchBooksNavigationController]
        
        self.viewControllers = viewControllers
        
        self.selectedIndex = 0
    }
    
    func configureTabBar() {
        self.tabBar.backgroundColor = .systemGroupedBackground
        self.tabBar.isTranslucent = true
    }
    
    func configureTabBarItem() {
        self.mvvm_ShowNewBooksViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "book"), tag: 0)
        
//        self.showNewBooksViewController.tabBarItem = UITabBarItem(title: "New", image: UIImage(systemName: "book"), tag: 0)
        
        self.searchBooksViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    }
}
