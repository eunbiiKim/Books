import UIKit

import SnapKit

import Then

class ShowDetailBookViewController: UIViewController {
    
    lazy var bookTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
        // FIXME: - 데이터주고받을때 completion 수정하기
        $0.text = "Microsoft Office Inside Out"
        //
    }
    
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    lazy var detailBookView = DetailBookView().then {
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.view.addSubview(self.bookTitleLabel)
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.detailBookView)
        
        self.setupViewsLayout()
    }
    
    func setupViewsLayout() {
        self.bookTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.bookTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.detailBookView.snp.makeConstraints {
            $0.top.centerX.equalTo(self.scrollView)
            $0.leading.trailing.bottom.equalTo(self.scrollView).inset(20)
            $0.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
        }
    }
}
