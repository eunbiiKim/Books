import UIKit

class TabBarController: UITabBarController {
    
    let showNewBooksViewController = ShowNewBooksViewController()
    
    let searchBooksViewController = SearchBooksViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [self.showNewBooksViewController, self.searchBooksViewController]
        
        self.viewControllers = viewControllers
        
        self.tabBar.backgroundColor = .systemGroupedBackground
    }
}
