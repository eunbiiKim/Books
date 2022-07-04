import Foundation

class BookModel {
    static let shared = BookModel()
    
    var books: [Book] = []
    
    var data: [String: Any] = [:]
    
    func loadData(path: String, query: String?, completionHandler: @escaping () -> Void) {
        // FIXME: - url 만드는 함수 따로 만들기
        let baseURL = "https://api.itbook.store"

        var urlComponent = URLComponents(string: baseURL)

        urlComponent?.path = "/1.0/\(path)"

        let query = "/"+(query ?? "")

        if path != "new" {
            urlComponent?.path.append(query)
        }
        
//         수정 -> alert -> alert 함수 만들기
        guard let requestURL = urlComponent?.url else { return }
        
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
                print("success")
                let jsonObject = try JSONSerialization.jsonObject(with: resultData, options: [])
//                print(jsonObject)
                guard let dictionay = jsonObject as? [String: Any] else { return }
                
                self.data = dictionay
                
                completionHandler()
                
//                switch dictionay.keys.count {
//                case 3:
//                    self.fetchNewBook(data: dictionay) {
//                        print("new")
//                    }
//                case 4:
//                    self.fetchSearchBookData {
//                        print("search")
//                    }
//                default:
//                    self.fetchDetailBookData {
//                        print("detail")
//                    }
//                }
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
        
        // 파싱해서 [book]]에 넣어야함
        let _books = data["books"] as! [[String: String]]
        _books.forEach { _book in
            var book = Book()
            book.title = _book["title"]
            book.subtitle = _book["subtitle"]
            book.isbn13 = _book["isbn13"]
            book.price = _book["price"]
            if let data = try? Data(contentsOf: URL(string: _book["image"]!)!) {
                book.image = data
            }
            self.books.append(book)
        }
        completionHandler()

    }
    // search 일때
    func fetchSearchBookData(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    // detail 일때 데이터 처리 함수 넣기
    func fetchDetailBookData(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}


