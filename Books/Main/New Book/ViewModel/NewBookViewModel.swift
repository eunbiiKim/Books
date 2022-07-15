import Foundation

import RxSwift
import RxCocoa

class NewBookViewModel {
    struct Input {
        let requestTrigger: PublishRelay<Void>
    }

    struct Output {
        let booksRelay: BehaviorRelay<[BookItem]>
    }
    
    // MARK: - Properties
    static let shared = NetworkService()
    
    let booksRelay = BehaviorRelay<[BookItem]>(value: [])
    
    var disposeBag = DisposeBag()
    
    // MARK: - Methods
    /// url 생성 함수
//    func configuraURL(_ path: String, _ query1: String?, _ query2: String?) -> URL? {
//        let baseURL = "https://api.itbook.store"
//
//        var urlComponent = URLComponents(string: baseURL)
//
//        switch path {
//            case "search":
//                urlComponent?.path = "/1.0/\(path)/\(query1!)/\(query2!)"
//            case "books":
//                urlComponent?.path = "/1.0/\(path)/\(query1!)"
//            default:
//                urlComponent?.path = "/1.0/\(path)"
//        }
//        return urlComponent?.url
//    }
    
//    func transform(path: String, query1: String?, query2: String?, request: Input) -> Output {
    func transform(request: Input) -> Output {
        request.requestTrigger
            .bind(onNext: { [weak self] in
                self?.loadData()
            }).disposed(by: disposeBag)
        return NewBookViewModel.Output(booksRelay: self.booksRelay)
    }
    


    
//    func loadBooksData(path: String, query1: String?, query2: String?) {
    func loadData() {

//        let requestURL = self.configuraURL(path, query1, query2)
        let requestURL = URL(string: "https://api.itbook.store/1.0/new")!

        let task = URLSession.shared.dataTask(with: URLRequest(url: requestURL)) { data, response, error in

            guard error == nil else {
                return
            }
            do {
                guard let _data = data else { return }

                let bookModel = try JSONDecoder().decode(BookModel.self, from: _data)
                
                guard let books = bookModel.books else { return }

                self.booksRelay.accept(books)
                
                print("~~~> books: \(books)")
                
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
