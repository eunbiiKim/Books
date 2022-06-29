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
        
        // FIXME: - navigation 인스턴스들을 어디서 생성할지
        /// new books
        let showNewBooksNavigationController = UINavigationController(rootViewController: self.firstTabViewController)
        
        showNewBooksNavigationController.navigationBar.prefersLargeTitles = true
        showNewBooksNavigationController.navigationBar.topItem?.title = "NewBooks"
        showNewBooksNavigationController.navigationBar.topItem?.largeTitleDisplayMode = .automatic
        
        showNewBooksNavigationController.navigationBar.backgroundColor = .white
        
        /// search books
        let searchBooksNavigationController = UINavigationController(rootViewController: self.secondTabViewController)
        
        searchBooksNavigationController.navigationBar.prefersLargeTitles = true
        searchBooksNavigationController.navigationBar.topItem?.title = "Search Books"
        searchBooksNavigationController.navigationBar.topItem?.largeTitleDisplayMode = .automatic
        
        let viewControllers = [showNewBooksNavigationController as UIViewController, searchBooksNavigationController as UIViewController]
        
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
