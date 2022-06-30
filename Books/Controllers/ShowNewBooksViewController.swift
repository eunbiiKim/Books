import UIKit

import SnapKit

import Then

class ShowNewBooksViewController: UIViewController {

    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.separatorStyle = .none

        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
    }
    
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
        
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ShowNewBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDetailBookViewController = ShowDetailBookViewController()
        
        // FIXME: - 데이터주고받을때 completion 수정하기
        self.present(showDetailBookViewController, animated: true, completion: nil)
    }
}

extension ShowNewBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: - 데이터주고받을때 수정하기
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier, for: indexPath)
        return cell
    }
}

