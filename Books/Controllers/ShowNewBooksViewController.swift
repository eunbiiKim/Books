import UIKit

import SnapKit

import Then

class ShowNewBooksViewController: UIViewController {
    
    lazy var bookModel = [[String: String]]()

    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.separatorStyle = .none

        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        $0.delegate = self
        
        $0.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: - PullToRefresh 화면 새로고침 기능 구현을 해야하기 때문에 데이터 로딩은 한번만 하면 됨.
        self.loadData()
        
        self.setupViewLayout()
        
        self.setupView()
    }
}

extension ShowNewBooksViewController {
    func setupViewLayout() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "New Books"

        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .automatic

        self.navigationController?.navigationBar.backgroundColor = .white

        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    func loadData() {
        NetworkService.shared.loadData(path: "new", query: nil) {
            self.bookModel = NetworkService.shared.bookModel.books ?? [[String: String]]()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ShowNewBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDetailBookViewController = ShowDetailBookViewController()
        
        let isbn13 = self.bookModel[indexPath.row]["isbn13"]!
        
        DispatchQueue.main.async {
            showDetailBookViewController.isbn13 = isbn13
            self.present(showDetailBookViewController, animated: true)
        }
    }
}

extension ShowNewBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.bookModel.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier, for: indexPath) as! NewBookTableViewCell
        cell.configureCell(by: self.bookModel[indexPath.row])
        return cell
    }
}

