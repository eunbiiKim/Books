import Foundation

class BookModel {
    static let shared = BookModel()
    
    lazy var books: [Book] = []
    
    lazy var data: [String: Any] = [:]
    
    // FIXME: - 이 url로 다 쓸거니까 혹시 프로퍼티 옵저버가 더 나은가?
    lazy var url = { (path: String, query: String?) -> URL? in
        let baseURL = "https://api.itbook.store"
        
        var urlComponent = URLComponents(string: baseURL)
        
        urlComponent?.path = "/1.0/\(path)"
        
        let query = "/"+(query ?? "")
        
        if path != "new" {
            urlComponent?.path.append(query)
        }
        // error handligin 만들기 -> alert 만들고 종료
        
        return urlComponent?.url
    }
    
    func loadData(path: String, query: String?, completionHandler: @escaping () -> Void) {
        
        guard let requestURL = self.url(path, query) else { return }
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            // client-side error
            guard error == nil else { return }
            
            // server-side error
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                // alertview 띄우기
                print("statusCode: \(statusCode)")
                return
            }
            
            guard let resultData = data else { return }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: resultData, options: [])
                
                guard let dictionary = jsonObject as? [String: Any] else { return }
                
                self.data = dictionary
                
                completionHandler()
                
            } catch let error {
                print("error: \(error.localizedDescription)")
                
                completionHandler()
            }
        }
        dataTask.resume()
    }
    
    // new 일때
    func fetchNewBook(data: [String: Any], completionHandler: @escaping () -> Void) {
        self.books = []
        
        let _books = data["books"] as! [[String: String]]
        _books.forEach { _book in
            var book = Book()
            book.title = _book["title"]
            book.subtitle = _book["subtitle"]
            book.isbn13 = _book["isbn13"]
            book.price = _book["price"]
            
            // FIXME: - 연속된 옵셔널 바인딩은 어떻게 처리되는지? -> if let? guard let? forced optional? 제어문 전환? / 예외상황이 어떻게 나올까 생각하는게 중요?
            guard let urlString = _book["image"] else {
                completionHandler()
                return
            }
            guard let imageURL = URL(string: urlString) else {
                completionHandler()
                return
            }
            guard let imageData = try? Data(contentsOf: imageURL) else {
                completionHandler()
                return
            }
            book.image = imageData
            
            self.books.append(book)
        }
        completionHandler()
    }
    // search 일때
    func fetchSearchBookData(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    // detail 일때
    func fetchDetailBookData(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}


