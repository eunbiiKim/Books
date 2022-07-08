import Foundation

import UIKit

import SnapKit

import Then

class NetworkService {
    // MARK: - stored properties
    static let shared = NetworkService()
    
    /// 데이터 받은 직후 데이터를 저장하기 위한 프로퍼티
    ///  -> 네트워크서비스를 싱글톤으로 접근 후 각 view controller에 있는 book model 에 넣기 위함.
    lazy var bookModel = BookModel()
    
    // MARK: - methods
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

    
//    /// 데이터 로드 함수
    func loadData(path: String, query1: String?, query2: String?, completionHandler: @escaping () -> Void) {

        guard let requestURL = self.configuraURL(path, query1, query2) else { return }

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
                completionHandler()
                return
            }
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()

                    guard let _data = data else {
                        completionHandler()
                        return
                    }
                    self.bookModel = try decoder.decode(BookModel.self, from: _data)

                    completionHandler()

                } catch let error {
                    print("error: \(error.localizedDescription)")
                    // FIXME: - alert view
                    completionHandler()
                }
            }
        }
        dataTask.resume()
    }
}


