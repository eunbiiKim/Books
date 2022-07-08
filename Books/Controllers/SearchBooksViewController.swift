import UIKit

import SnapKit

import Then

class SearchBooksViewController: UIViewController {
    // MARK: - stored properties
    typealias BookModel = [[String: String]]
    
    lazy var bookModel: BookModel? = BookModel()
    
    lazy var filteredBookModel = BookModel()
    
    lazy var networkService = NetworkService.shared
    
    lazy var page = 1
    
    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        $0.register(SearchBookTableViewCell.self, forCellReuseIdentifier: SearchBookTableViewCell.identifier)
        
        $0.register(NoResultTableViewCell.self, forCellReuseIdentifier: NoResultTableViewCell.identifier)
    }
    
    lazy var activityIndicator = UIActivityIndicatorView().then {
        $0.hidesWhenStopped = true
        $0.style = .large
        $0.stopAnimating()
    }
    
    // MARK: - view controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewLayout()
        
        self.setupView()
    }
}

// MARK: - set up view
extension SearchBooksViewController {
    func setupViewLayout() {
        self.view.addSubview(self.tableView)
        
        self.view.addSubview(self.activityIndicator)
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Search Books"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "검색어를 입력해보세요"
        
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationController?.navigationBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.tableView.separatorStyle = .none
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.setContentOffset(CGPoint(x: 0.0, y: self.tableView.contentOffset.y), animated: true)
    }
}

// MARK: - scroll view delegate
extension SearchBooksViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.tableView.bounces = true
        
        guard let tabBarController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? TabBarController else { return }
        
        if (self.tableView.contentSize.height - self.tableView.frame.size.height) == (self.tableView.contentOffset.y - tabBarController.tabBar.frame.height) {
//            self.tableView.bounces = false
            scrollViewDidEndScrollingAnimation(scrollView)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.page += 1
        NetworkService.shared.loadData(
            path: "search",
            query1: self.navigationItem.searchController?.searchBar.text,
            query2: "\(self.page)"
        ) {
            self.bookModel = BookModel.init()
            self.bookModel = NetworkService.shared.bookModel.books ?? [[:]]
            
            if self.bookModel?.count != 0 {
                self.filteredBookModel += self.bookModel!

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.makeAlert()
            }
        }
    }
    
    // FIXME: - extension으로 넣어놓기
    func makeAlert() {
        let alertController = UIAlertController(
            title: "더이상 검색 결과가 없습니다.",
            message: nil,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {
            self.page -= 1
        }
    }
}

// MARK: - search result updating delegate
extension SearchBooksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // MARK: - load data
        self.page = 1
        
        NetworkService.shared.loadData(
            path: "search",
            query1: searchController.searchBar.text,
            query2: "\(self.page)"
        ) {
            self.activityIndicator.startAnimating()
            self.bookModel?.removeAll()
            self.bookModel = NetworkService.shared.bookModel.books ?? [[:]]
            self.filteredBookModel = self.bookModel!
            
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - table view delegate
extension SearchBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.filteredBookModel.count != 0 {
            self.tableView.allowsSelection = true
            
            let showDetailBookViewController = ShowDetailBookViewController()
            let isbn13 = self.filteredBookModel[indexPath.row]["isbn13"]
            
            DispatchQueue.main.async {
                showDetailBookViewController.isbn13 = isbn13
                self.present(showDetailBookViewController, animated: true)
            }
        } else {
            self.tableView.allowsSelection = false
        }
    }
}

// MARK: - table view data source
extension SearchBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.navigationItem.searchController?.searchBar.text == "" {
            return 0
        } else {
            if self.filteredBookModel.count != 0 {
                return self.filteredBookModel.count
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.filteredBookModel.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchBookTableViewCell.identifier, for: indexPath) as! SearchBookTableViewCell
            cell.configureView(by: self.filteredBookModel[indexPath.row])
            self.tableView.separatorStyle = .singleLine
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoResultTableViewCell.identifier, for: indexPath) as! NoResultTableViewCell
            
            self.tableView.separatorStyle = .none
            return cell
        }
    }
}


