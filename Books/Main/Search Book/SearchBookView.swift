import UIKit

import SnapKit

import RxSwift
import RxCocoa

class SearchBookView: UIView {
    var disposeBag = DisposeBag()
    
    let booksRelay = BehaviorRelay<[BookItem]>(value: [])
    
    let viewActionTrigger = PublishRelay<SearchBookViewAction>()
    
    lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        
        $0.register(NewBookTableViewCell.self, forCellReuseIdentifier: NewBookTableViewCell.identifier)
        
        $0.register(SearchBookTableViewCell.self, forCellReuseIdentifier: SearchBookTableViewCell.identifier)
        
        $0.register(NoResultTableViewCell.self, forCellReuseIdentifier: NoResultTableViewCell.identifier)
        
        $0.refreshControl = UIRefreshControl()
        
        $0.refreshControl?.addTarget(
            self,
            action: #selector(self.handleRefreshControl),
            for: .valueChanged
        )
    }
    
    @objc private func handleRefreshControl() {}
    
    // MARK: - initialize methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLayout()
    }
}

// MARK: - SetUp DI
extension SearchBookView {
    // ViewModel > View
    func setupDI(relay: BehaviorRelay<[BookItem]>) {
        relay.bind(to: self.booksRelay).disposed(by: disposeBag)
    }
    
    // View > ViewModel
    func setupDI(relay: PublishRelay<SearchBookViewAction>) {
        relay.bind(to: self.viewActionTrigger).disposed(by: disposeBag)
    }
}

// MARK: - set up view methods
extension SearchBookView {
    func setupLayout() {
        self.backgroundColor = .white
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
