import Foundation

import RxSwift
import RxCocoa

class NetworkService {
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
    func configuraURL(_ path: String, _ query1: String?, _ query2: String?) -> URL? {
        let baseURL = "https://api.itbook.store"
        
        var urlComponent = URLComponents(string: baseURL)
        
        switch path {
            case "search":
                urlComponent?.path = "/1.0/\(path)/\(query1!)/\(query2!)"
            case "books":
                urlComponent?.path = "/1.0/\(path)/\(query1!)"
            default:
                urlComponent?.path = "/1.0/\(path)"
        }
        // error handligin 만들기 -> alert 만들고 return
        
        return urlComponent?.url
    }
    
    func transform(path: String, query1: String?, query2: String?, request: Input) -> Output {
        request.requestTrigger
            .bind { [weak self] _ in
                self?.loadBooksData(path: path, query1: query1, query2: query2)
            }.disposed(by: disposeBag)
        return Output(booksRelay: self.booksRelay)
    }
    
    func loadBooksData(path: String, query1: String?, query2: String?) {

        let requestURL = self.configuraURL(path, query1, query2)

        let task = URLSession.shared.dataTask(with: URLRequest(url: requestURL!)) { data, response, error in

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
    
    /// 데이터 로드 함수 -> New
    func loadData(path: String, query1: String?, query2: String?) -> Observable<BookModel> {

        return Observable.create { emitter in

            let requestURL = self.configuraURL(path, query1, query2)

            let task = URLSession.shared.dataTask(with: URLRequest(url: requestURL!)) { data, response, error in

                guard error == nil else {
                    emitter.onError(error!)
                    return
                }
                do {
                    guard let _data = data else { return }

                    let bookModel = try JSONDecoder().decode(BookModel.self, from: _data)

                    emitter.onNext(bookModel)

                    emitter.onCompleted()

                } catch let error {
                    print("error: \(error.localizedDescription)")
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    
    /// 데이터 로드 함수 -> Search / Detail
    func loadData(path: String, query1: String?, query2: String?, completionHandler: @escaping (BookModel) -> Void) {
        
        guard let requestURL = self.configuraURL(path, query1, query2) else { return }
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            // client-side error
            guard error == nil else { return }
            
            // server-side error
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                // alertview 띄우기
                print("statusCode: \(statusCode)")
                completionHandler(BookModel())
                return
            }
            do {
                guard let _data = data else {
                    completionHandler(BookModel())
                    return
                }
                let bookModel = try JSONDecoder().decode(BookModel.self, from: _data)
                
                completionHandler(bookModel)
                
            } catch let error {
                print("error: \(error.localizedDescription)")
                // FIXME: - alert view
                completionHandler(BookModel())
            }
        }.resume()
    }
}
