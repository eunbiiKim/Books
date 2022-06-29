import UIKit

class ShowNewBooksViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorStyle = .none

        tableView.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "New Books"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .automatic

        self.navigationController?.navigationBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.frame = self.view.bounds
        
        self.view.addSubview(self.tableView)
    }
}

extension ShowNewBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDetailBookViewController = ShowDetailBookViewController()
        self.present(showDetailBookViewController, animated: true, completion: nil)
    }
}

extension ShowNewBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier, for: indexPath)
        return cell
    }
}

