import UIKit

import SnapKit

import Then

import RxSwift

import RxCocoa

class MVVM_ShowNewBooksViewController: UIViewController, UITableViewDelegate {
    //MARK: - Properties
    
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
    
    let viewModel = NewBooksViewModel()
    
    let disposeBag = DisposeBag()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewLayout()
        
        self.setupView()
        
        self.viewModel.reload(true)
        
        self.bind()
    }
}

extension MVVM_ShowNewBooksViewController {
    func bind() {
        self.viewModel.books
            .observe(on: MainScheduler.instance)
            .bind(to: self.tableView.rx.items(cellIdentifier: "\(NewBookTableViewCell.self)")) { row, viewModel, cell in
                
                let cell = cell as! NewBookTableViewCell
                cell.configureCell(by: viewModel)
            }
            .disposed(by: disposeBag)
        
        self.tableView.rx.didScroll
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let tabBarController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as? TabBarController else { return }
                
                let contentHeight = Int(self?.tableView.contentSize.height ?? 0.0)
                let frameHeight = Int(self?.tableView.frame.size.height ?? 0.0)
                let contentOffsetY = Int(self?.tableView.contentOffset.y ?? 0.0)
                let tabBarHeight = Int(tabBarController.tabBar.frame.height)
                
                if (contentHeight - frameHeight) == (contentOffsetY - tabBarHeight) {
                    self?.viewModel.reload(false)
                }
            }).disposed(by: disposeBag)
    }
    
    @objc /// Table view refresh
    func handleRefreshControl() {
        self.viewModel.reload(true)
        
        self.tableView.refreshControl?.endRefreshing()
    }
}

extension MVVM_ShowNewBooksViewController {
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
}

