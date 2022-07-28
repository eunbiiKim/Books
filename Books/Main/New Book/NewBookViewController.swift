import UIKit

import SnapKit

import Then

import RxSwift

import RxCocoa

class NewBookViewController: UIViewController {
    //MARK: - Property
    lazy var mainView: NewBookView = NewBookView()
    
    let viewModel = NewBookViewModel()
    
    let requestTrigger = PublishRelay<Void>()
    
    let viewActionTrigger = PublishRelay<NewBookViewAction>()
    
    let disposeBag = DisposeBag()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewLayout()
        
        self.setupView()

        self.bind()
        
        self.requestTrigger.accept(())
    }
}

//MARK: - Method
extension NewBookViewController {
    func bind() {
        let output = self.viewModel.transform(req: NewBookViewModel.Input.init(requestTrigger: self.requestTrigger, viewActionTrigger: self.viewActionTrigger))
        
        self.mainView.setupDI(relay: output.booksRelay)
        
        self.mainView.setupDI(relay: self.viewActionTrigger)
    }
}

//MARK: - Setup view
extension NewBookViewController {
    func setupViewLayout() {
        self.view.addSubview(self.mainView)
        
        self.mainView.snp.makeConstraints {
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

