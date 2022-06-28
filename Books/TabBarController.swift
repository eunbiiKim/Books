import UIKit

class TabBarController: UITabBarController {
    
    let showNewBooksViewController = ShowNewBooksViewController()
    
    let searchBooksViewController = SearchBooksViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
