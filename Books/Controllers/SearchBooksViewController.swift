import UIKit

import SnapKit

import Then

class SearchBooksViewController: UIViewController {

    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false

        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        $0.register(SearchBookTableViewCell.self, forCellReuseIdentifier: SearchBookTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Search Books"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationController?.navigationBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self

        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchBooksViewController: UITableViewDelegate {
}

extension SearchBooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: - 데이터주고받을때 completion 수정하기
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchBookTableViewCell.identifier, for: indexPath)
        return cell
    }

}


