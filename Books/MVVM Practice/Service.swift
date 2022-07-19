// Repository로 받은 Entity를 가지고 Model을 만들어서 뷰모델로 뿌려줌

import Foundation

struct Service {
    func loadData(completionHandler: @escaping (NewBooksJSON) -> Void) {

        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
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
            do {
                guard let _data = data else { return }

                let entity = try JSONDecoder().decode(NewBooksJSON.self, from: _data)

                completionHandler(entity)

            } catch let error {
                print("error: \(error.localizedDescription)")
                // FIXME: - alert view
            }
        }.resume()
    }

    func fetchBooks(completionHandler: @escaping ([BookItem]) -> Void) {
        self.loadData { entity in
            guard let books = entity.books else { return }
            completionHandler(books)
        }
    }
}

