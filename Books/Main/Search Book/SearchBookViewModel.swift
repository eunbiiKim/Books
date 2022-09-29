//
//  SearchBooksViewModel.swift
//  Books
//
//  Created by pineone on 2022/09/29.
//

import Foundation

import RxCocoa
import RxSwift

enum SearchBookViewAction {
    case reloadData // 검색어가 바뀔때마다 실시간으로 책 목록도 바꾸어주어야함.
    case goDetailPage(IndexPath) // 디테일 페이지로 진입
    case didScroll // 키보드를 내리기위한 액션
    case endScroll // 스크롤 하단을 찍었을때 책 목록이 더 있을 시 보여주어야함.
}

class SearchBookModel {
    var books: [BookItem] = []
}

class SearchBookViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    // SearchBookViewModel의 Model
    var booksModel: [BookItem] = []

    // SearchBookViewModel의 ViewModel
    var books: BehaviorRelay<[BookItem]> = BehaviorRelay<[BookItem]>(value: [])

    struct Input {
        let requestTrigger: PublishRelay<Void>
        let searchText: PublishRelay<String>
        let viewActionTrigger: PublishRelay<SearchBookViewAction>
    }
    
    struct Output {
        let booksRelay: BehaviorRelay<[BookItem]>
    }
    
    func transform(req: Input) -> Output {
        req.viewActionTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, element in
                self.doAction(element)
            })
            .disposed(by: disposeBag)
        
        req.requestTrigger
            .subscribe(onNext: { [weak self] _ in
                self?.reload(true)
            })
            .disposed(by: disposeBag)
        return SearchBookViewModel.Output(booksRelay: self.books)
    }
    
    private func doAction(_ action: SearchBookViewAction) {
        switch action {
            case .reloadData:
                // 데이터리로드
                self.reload(true)
            case .goDetailPage(let index):
                // 디테일 페이지로 가기
                self.goDetailPage(index)
            case .didScroll:
                // 키보드 내리기
                self.keyboardDisappear()
            case .endScroll:
                // 페이지 더 추가
                self.addPage()
        }
    }
    
    private func reload(_ bool: Bool) {
        print(#function)
    }    
    private func goDetailPage(_ index: IndexPath) {
        print(#function)
    }
    private func keyboardDisappear() {
        print(#function)
    }
    private func addPage() {
        print(#function)
    }
}

