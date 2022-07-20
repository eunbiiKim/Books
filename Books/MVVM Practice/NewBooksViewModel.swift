import Foundation
import RxCocoa
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(req: Input) -> Output
}

// 공통 기능이 있으면 여기에 정의
//extension ViewModelType {
//
//}

// 1.Model에게 요청
// 2.Model에게서 받아온 data를 view model에 맞게 가공
// 3.최종적으로 view model 데이터 뽑기.
class NewBooksViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let requestTrigger: PublishRelay<Void>
    }
    
    struct Output {
        let booksRelay: BehaviorRelay<[BookItem]>
    }
    
    func transform(req: Input) -> Output {
        req.requestTrigger
            .bind(onNext: { [weak self] _ in
                self?.reload(true)
            })
            .disposed(by: disposeBag)
        return NewBooksViewModel.Output(booksRelay: self.books)
    }

    // MARK: - Property
    /// NetworkService
    let service = Service()
    
    /// Model
    var booksModel: [BookItem] = []
    
    /// viewModel
    var books: BehaviorRelay<[BookItem]> = BehaviorRelay<[BookItem]>(value: [])
}


// MARK: - Method
extension NewBooksViewModel {
    func reload(_ trigger: Bool) {
        if !trigger {
            self.fetchNewBooksViewModel()
        } else {
            self.service.fetchBooks { books in
                self.booksModel = books
                self.books.accept([])
                self.fetchNewBooksViewModel()
            }
        }
    }
    
    func fetchNewBooksViewModel() {
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
}
