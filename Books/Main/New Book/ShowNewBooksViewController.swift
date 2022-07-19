import UIKit

import SnapKit

import Then

import RxCocoa
import RxSwift

class ShowNewBooksViewController: UIViewController {
    //MARK: - Properties
    var disposeBag = DisposeBag()
    
    let viewModel = NewBookViewModel()
    
    let requestTrigger = PublishRelay<Void>()
    
    lazy var books: [BookItem] = []
    
    lazy var filteredBooks: [BookItem] = []
    
    var dataRelay = BehaviorRelay<[BookItem]>(value: [])
    
    var countingCompletedScroll = 0
    
    lazy var tableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.separatorStyle = .none
        
        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        $0.refreshControl = UIRefreshControl()
        
        $0.refreshControl?.addTarget(
            self,
            action: #selector(self.handleRefreshControl),
            for: .valueChanged
        )
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        self.requestTrigger.accept(())
        
        self.setupViewLayout()
        
        self.setupView()
        
        self.bind()
        
    }
}

extension ShowNewBooksViewController {
    //MARK: - Setup view
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
    
    //MARK: - Load data
    func loadData() {
        let request = viewModel.transform(request: NewBookViewModel.Input.init(requestTrigger: self.requestTrigger))
        
        self.filteredBooks.removeAll()
        request.booksRelay
            .subscribe(onNext: { books in
                self.books = books
                self.dataRelay.accept(self.convertFilteredBookModel())
            })
            .disposed(by: disposeBag)
    }
    
    
    @objc /// Table view refresh
    func handleRefreshControl() {
        self.loadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    /// new book 목록에 5개씩 보이게 하는 함수
    func convertFilteredBookModel() -> [BookItem] {
        var i: Int? = 0
        if self.books.count > 0 {
            repeat {
                i! += 1
                if i != nil {
                    self.filteredBooks.append(self.books[0])
                    self.books.remove(at: 0)
                } else { break }
            } while (i! < 5)
        }
        return self.filteredBooks
    }
}

extension ShowNewBooksViewController {
    func bind() {
        // TableView
        self.tableView.rx.itemSelected
            .asDriver(onErrorJustReturn: IndexPath())
            .drive(onNext: { indexPath in
                let showDetailBookViewController = ShowDetailBookViewController()
                
                if let isbn13 = self.filteredBooks[indexPath.row].isbn13 {
                    showDetailBookViewController.isbn13 = isbn13
                    self.present(showDetailBookViewController, animated: true)
                }
            }).disposed(by: disposeBag)
        
        self.dataRelay
            .asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier) as! NewBookTableViewCell
                cell.configureCell(by: item)
                return cell
            }.disposed(by: disposeBag)
        
        
        // ScrollView
        self.tableView.rx.didScroll
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let tabBarController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? TabBarController else { return }
                
                let contentHeight = Int(self?.tableView.contentSize.height ?? 0.0)
                let frameHeight = Int(self?.tableView.frame.size.height ?? 0.0)
                let contentOffsetY = Int(self?.tableView.contentOffset.y ?? 0.0)
                let tabBarHeight = Int(tabBarController.tabBar.frame.height)
                
                if (contentHeight - frameHeight) == (contentOffsetY - tabBarHeight) {
                    self?.countingCompletedScroll += 1
                    if self?.countingCompletedScroll == 1 {
                        self?.dataRelay.accept((self?.convertFilteredBookModel())!)
                    }
                } else {
                    self?.countingCompletedScroll = 0
                }
            }).disposed(by: disposeBag)
    }
}

