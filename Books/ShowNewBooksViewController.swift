import UIKit

class ShowNewBooksViewController: UIViewController {
    override func loadView() {
        self.view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "New"
        print("ShowNewBooksViewController")
    }
}

