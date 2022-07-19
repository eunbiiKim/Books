import Foundation
import RxCocoa

class ViewModel {
    
    var onUpdated: () -> Void = {}

    let service = Service()
    
    var books: BehaviorRelay<[BookItem]> = BehaviorRelay<[BookItem]>(value: [])
    
    func reload(completionHandler: @escaping () -> Void) {
        self.service.fetchBooks { model in
            self.books.accept(model.books)
            completionHandler()
        }
    }
}
