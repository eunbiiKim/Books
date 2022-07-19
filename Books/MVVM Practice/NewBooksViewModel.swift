import Foundation
import RxCocoa

// 1.Model에게 요청
// 2.Model에게서 받아온 data를 view model에 맞게 가공
// 3.최종적으로 view model 데이터 뽑기.
class NewBooksViewModel {
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
