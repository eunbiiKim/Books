import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()
    
    lazy var bookModel = BookModel()
    
    func configuraURL(_ path: String, _ query: String?) -> URL? {
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
        
        guard let requestURL = self.configuraURL(path, query) else { return }

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
        dataTask.resume()
    }
}


