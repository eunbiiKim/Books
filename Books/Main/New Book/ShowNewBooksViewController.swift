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
    
    var dataSource = BehaviorSubject<[BookItem]>(value: [])
    
    var dataSource2 = BehaviorRelay<[BookItem]>(value: [])
    
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
//        self.bind()

        self.setupViewLayout()

        self.setupView()
        
        self.loadData()
        
        self.bindToScrollView()
        
        self.bindToTableView()
        
        
    }
    
    func loadData() {
        let req = viewModel.transform(request: NewBookViewModel.Input.init(requestTrigger: self.requestTrigger))
        
        self.setupDI(relay: req.booksRelay)
    }
    
    func setupDI(relay: BehaviorRelay<[BookItem]>) {
        relay.bind(to: self.dataRelay).disposed(by: disposeBag)
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
    }
    
    @objc
    func handleRefreshControl() {
        self.loadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    //MARK: - load data
//    func loadData() {
//        NetworkService.shared.loadData(
//            path: "new",
//            query1: nil,
//            query2: nil)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { bookModel in
//                guard let books = bookModel.books else { return }
//                self.books = books
//                self.filteredBooks.removeAll()
//                self.dataSource.onNext(self.convertFilteredBookModel())
//            })
//            .disposed(by: self.disposeBag)
//    }
    
    //MARK: - methods
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
    func bindToScrollView() {
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
                        self?.dataSource.onNext((self?.convertFilteredBookModel())!)
                    }
                } else {
                    self?.countingCompletedScroll = 0
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindToTableView() {
        self.tableView.delegate = nil

        self.tableView.dataSource = nil
        
        self.tableView.rx.itemSelected
            .asDriver(onErrorJustReturn: IndexPath())
            .drive(onNext: { indexPath in
                let showDetailBookViewController = ShowDetailBookViewController()
                
                if let isbn13 = self.filteredBooks[indexPath.row].isbn13 {
                    showDetailBookViewController.isbn13 = isbn13
                    self.present(showDetailBookViewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        self.dataRelay
            .asDriver(onErrorJustReturn: [])
            .drive(self.tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier) as! NewBookTableViewCell
                cell.configureCell(by: item)
                return cell
            }
            .disposed(by: disposeBag)
        
//        self.dataSource
//            .asDriver(onErrorJustReturn: [])
//            .drive(self.tableView.rx.items) { tableView, row, item in
//                let cell = tableView.dequeueReusableCell(withIdentifier: NewBookTableViewCell.identifier) as! NewBookTableViewCell
//                cell.configureCell(by: item)
//                return cell
//            }
//            .disposed(by: disposeBag)
    }
}

