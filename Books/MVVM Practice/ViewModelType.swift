import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(req: Input) -> Output
}

// 공통 기능이 있으면 여기에 정의
//extension ViewModelType {
//
//}
