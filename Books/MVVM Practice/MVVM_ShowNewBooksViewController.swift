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
    
    let viewModel = ViewModel()
    
    let disposeBag = DisposeBag()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewLayout()
        
        self.setupView()

        self.viewModel.reload {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.books
            .observe(on: MainScheduler.instance)
            .bind(to: self.tableView.rx.items(cellIdentifier: "\(NewBookTableViewCell.self)")) { row, viewModel, cell in
                
                let cell = cell as! NewBookTableViewCell
                cell.configureCell(by: viewModel)
            }
            .disposed(by: disposeBag)
            
    }
}

extension MVVM_ShowNewBooksViewController {
    @objc /// Table view refresh
    func handleRefreshControl() {
        self.viewModel.reload {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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

