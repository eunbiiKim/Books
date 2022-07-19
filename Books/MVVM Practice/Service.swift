// Repository로 받은 Entity를 가지고 Model을 만들어서 뷰모델로 뿌려줌

import Foundation

struct Service {
    
    let repository = Repository()

    func fetchBooks(completionHandler: @escaping (Model) -> Void) {
        repository.loadData { entity in
            guard let books = entity.books else { return }
            let model = Model(books: books)
            completionHandler(model)
        }
    }
}

