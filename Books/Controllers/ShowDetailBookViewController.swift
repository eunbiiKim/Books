import UIKit

import SnapKit

class ShowDetailBookViewController: UIViewController {
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        // FIXME: - 데이터주고받을때 completion 수정하기
        label.text = "Microsoft Office Inside Out"
        //
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let detailBookView: DetailBookView = {
        let view = DetailBookView()
        view.backgroundColor = .white
        return view
    }()
    
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
            $0.top.equalTo(self.view).offset(10)
            $0.leading.equalTo(self.view).offset(20)
            $0.trailing.equalTo(self.view).offset(-20)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.bookTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(self.view)
        }
        
        self.detailBookView.snp.makeConstraints {
            $0.top.centerX.equalTo(self.scrollView)
            $0.leading.equalTo(self.scrollView).offset(20)
            $0.trailing.bottom.equalTo(self.scrollView).offset(-20)
            $0.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
        }
    }
}
