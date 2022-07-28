import UIKit

import Then

import SnapKit

import RxSwift
import RxRelay

class NewBookView: UIView {
    
    // MARK: Property
    var disposeBag = DisposeBag()
    
    let booksRelay = BehaviorRelay<[BookItem]>(value: [])
    
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
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupTableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTableView()
    }
    
    // NewBookView -> NewBookViewModel Trigger
    let viewActionTrigger: PublishRelay<NewBookViewAction> = PublishRelay<NewBookViewAction>()
}

extension NewBookView {
    // MARK: Dependency Injection
    /// NewBookViewModel -> NewBookView DI
    func setupDI(relay: BehaviorRelay<[BookItem]>) {
        relay.bind(to: self.booksRelay).disposed(by: disposeBag)
    }
    
    /// NewBookView -> NewBookViewModel DI
    func setupDI(relay: PublishRelay<NewBookViewAction>) {
        self.viewActionTrigger.bind(to: relay).disposed(by: disposeBag)
    }
    
    @objc /// Table view refresh
    func handleRefreshControl() {
        self.viewActionTrigger.accept(.reloadData)
        
        self.tableView.refreshControl?.endRefreshing()
    }
}

// MARK: Setup View
extension NewBookView {
    fileprivate func setupTableView() {
        booksRelay
            .bind(to: tableView.rx.items(cellIdentifier: "\(NewBookTableViewCell.self)"))
        { row, bookItem, cell in
            let cell = cell as! NewBookTableViewCell
            cell.configureCell(by: bookItem)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asDriver(onErrorJustReturn: IndexPath())
            .drive(onNext: { [weak self] indexPath in
                self?.viewActionTrigger.accept(.goDetailPage(indexPath))
            }).disposed(by: disposeBag)
        
        tableView.rx.didScroll
            .subscribe(onNext: { [weak self] in
                guard let tabBarController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? TabBarController else { return }
                
                let contentHeight = Int(self?.tableView.contentSize.height ?? 0.0)
                let frameHeight = Int(self?.tableView.frame.size.height ?? 0.0)
                let contentOffsetY = Int(self?.tableView.contentOffset.y ?? 0.0)
                let tabBarHeight = Int(tabBarController.tabBar.frame.height)
                
                if (contentHeight - frameHeight) == (contentOffsetY - tabBarHeight) {
                    self?.viewActionTrigger.accept(.addPage)
                }
            }).disposed(by: disposeBag)
    }
    
    fileprivate func setupView() {
        self.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
