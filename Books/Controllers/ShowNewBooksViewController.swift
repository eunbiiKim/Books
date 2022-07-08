import UIKit

import SnapKit

import Then

class ShowNewBooksViewController: UIViewController {
    //MARK: - stored properties
    typealias BookModel = [[String: String]]
    
    lazy var bookModel = BookModel()
    
    lazy var filteredBookModel = BookModel()

    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.separatorStyle = .none

        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        $0.delegate = self
        
        $0.dataSource = self
    }

    //MARK: - view controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
        
        self.setupViewLayout()
        
        self.setupView()
    }
}

extension ShowNewBooksViewController {
    //MARK: - setup view
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
        
        
        self.configureRefreshControl()
    }
    
    func configureRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(
            self,
            action: #selector(self.handleRefreshControl),
            for: .valueChanged
        )
    }
    
    @objc
    func handleRefreshControl() {
        self.loadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    //MARK: - load data
    func loadData() {
        NetworkService.shared.loadData(
            path: "new",
            query1: nil,
            query2: nil
        ) {
            self.bookModel = NetworkService.shared.bookModel.books ?? BookModel()
            self.filteredBookModel.removeAll()
            self.filtereBookModel {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - methods
    /// new book 목록에 5개씩 보이게 하는 함수
    func filtereBookModel(completaionHandler: @escaping () -> Void) {
        var i = 0
        if self.bookModel.count > 0 {
            repeat {
                i += 1
                self.filteredBookModel.append(self.bookModel[0])
                self.bookModel.remove(at: 0)
            } while (self.bookModel.count < 6) ? (i < self.bookModel.count) : (i < 5)
            completaionHandler()
        }
    }
}

//MARK: - scroll view delegate
extension ShowNewBooksViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tabBarController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? TabBarController else { return }
        
        if (self.tableView.contentSize.height - self.tableView.frame.size.height) == (self.tableView.contentOffset.y - tabBarController.tabBar.frame.height) {
            scrollViewDidEndScrollingAnimation(scrollView)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.filtereBookModel {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


//MARK: - tableview view delegate
extension ShowNewBooksViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDetailBookViewController = ShowDetailBookViewController()
        
        if let isbn13 = self.filteredBookModel[indexPath.row]["isbn13"] {
            DispatchQueue.main.async {
                showDetailBookViewController.isbn13 = isbn13
                self.present(showDetailBookViewController, animated: true)
            }
        } 
    }
}

//MARK: - tableview view data source
extension ShowNewBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.filteredBookModel.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier, for: indexPath) as! NewBookTableViewCell
        cell.configureCell(by: self.filteredBookModel[indexPath.row])
        return cell
    }
}

