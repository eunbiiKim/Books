import UIKit

import SnapKit

import Then

class ShowNewBooksViewController: UIViewController {

    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.separatorStyle = .none

        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
    }
    
    lazy var bookModel = BookModel.shared
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bookModel.loadData(path: "new", query: nil) {
            self.bookModel.fetchNewBook(data: self.bookModel.data) {
                print("books1: \(self.bookModel.books.count)")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        return self.bookModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier, for: indexPath) as! NewBookTableViewCell
        cell.setupCell(viewModel: self.bookModel.books, row: indexPath.row)
        return cell
    }
}

