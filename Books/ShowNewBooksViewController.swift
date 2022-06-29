import UIKit

class ShowNewBooksViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "New Books"
        
        self.navigationController?.navigationBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.frame = self.view.bounds
        
        self.view.addSubview(self.tableView)
    }
}

extension ShowNewBooksViewController: UITableViewDelegate {}

extension ShowNewBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

