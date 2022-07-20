import Foundation

enum BooksURL: String {
    case new = "https://api.itbook.store/1.0/new"
    case search = "https://api.itbook.store/1.0/search/"
    case detail = "https://api.itbook.store/1.0/books/"
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(req: Input) -> Output
}

// 공통 기능이 있으면 여기에 정의
//extension ViewModelType {
//
//}
