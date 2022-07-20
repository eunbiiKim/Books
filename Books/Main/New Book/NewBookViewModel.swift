import Foundation

import RxCocoa
import RxSwift

enum NewBookViewAction {
    case reloadData
    case addPage
    case goDetailPage(IndexPath)
}

class NewBookModel {
    var books: [BookItem] = []
}

class NewBookViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    // MARK: - Property
    /// Model
    var booksModel: [BookItem] = []
    
    /// viewModel
    var books: BehaviorRelay<[BookItem]> = BehaviorRelay<[BookItem]>(value: [])
    
    struct Input {
        let requestTrigger: PublishRelay<Void>
        let viewActionTrigger: PublishRelay<NewBookViewAction>
    }
    
    struct Output {
        let booksRelay: BehaviorRelay<[BookItem]>
    }
    
    func transform(req: Input) -> Output {
        req.viewActionTrigger
            .subscribe(onNext: { [weak self] action in
                self?.doAction(action)
            }).disposed(by: disposeBag)
        
        req.requestTrigger
            .bind(onNext: { [weak self] _ in
                self?.reload(true)
            })
            .disposed(by: disposeBag)
        return NewBookViewModel.Output(booksRelay: self.books)
    }
}


// MARK: - Method
extension NewBookViewModel {
    func reload(_ trigger: Bool) {
        if !trigger {
            self.fetchNewBookViewModel()
        } else {
            NetworkService.shared.url.accept(BooksURL.new.rawValue)
            NetworkService.shared.fetchBooks { books in
                self.booksModel = books
                self.books.accept([])
                self.fetchNewBookViewModel()
            }
        }
    }
    
    func fetchNewBookViewModel() {
        var viewModel: [BookItem] = []
        if self.books.value.count != 0 {
            let count = self.books.value.count
            
            if self.booksModel.count != self.books.value.count {
                viewModel += self.books.value
                (self.booksModel[count...count+4]).forEach { book in
                    viewModel.append(book)
                }
                self.books.accept(viewModel)
            }
        } else {
            (self.booksModel[0...4]).forEach { book in
                viewModel.append(book)
            }
            self.books.accept(viewModel)
        }
    }
    
    func doAction(_ action: NewBookViewAction) {
        switch action {
            case .addPage:
                self.reload(false)
            case .reloadData:
                self.reload(true)
            case .goDetailPage:
                self.goDetailPage()
        }
    }
    
    func goDetailPage() {
        let showDetailBookViewController = ShowDetailBookViewController()
        
//        if let isbn13 = self.booksRelay.value[indexPath.row].isbn13 {
        if let isbn13 = Output().booksRelay.value[IndexPath().row].isbn13 {
            showDetailBookViewController.isbn13 = isbn13
//                    self.present(showDetailBookViewController, animated: true)
        }
    }
}
