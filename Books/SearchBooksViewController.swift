import UIKit

class SearchBooksViewController: UIViewController {
    override func loadView() {
        self.view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.title = "Search"
        print("SearchBooksViewController")
    }
}


