import UIKit

import SnapKit

import Then

class ShowDetailBookViewController: UIViewController {
    
    lazy var bookModel: BookModel? = nil
    
    lazy var isbn13: String? = nil
    
    lazy var bookTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = nil
    }
    
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    lazy var detailBookView = DetailBookView().then {
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewLayout()

        self.loadData()
    }
}

extension ShowDetailBookViewController {
    func setupViewLayout() {
        self.view.backgroundColor = .white

        self.view.addSubview(self.bookTitleLabel)
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.detailBookView)
        
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
    
    func setupView() {
        DispatchQueue.main.async {
            guard let url = URL(string: self.bookModel?.image ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            self.detailBookView.imageView.image = UIImage(data: imageData)
        }
        self.bookTitleLabel.text = self.bookModel?.title ?? ""
        self.detailBookView.titleLabel.text = self.bookModel?.title ?? ""
        self.detailBookView.subtitleLabel.text = self.bookModel?.subtitle ?? ""
        self.detailBookView.isbn13Label.text = self.bookModel?.isbn13 ?? ""
        self.detailBookView.priceLabel.text = self.bookModel?.price ?? ""
        self.detailBookView.urlLinkLabel.text = self.bookModel?.url ?? ""
    }
    
    func loadData() {
        NetworkService.shared.loadData(path: "books", query: self.isbn13) {
            self.bookModel = NetworkService.shared.bookModel
            self.setupView()
        }
    }
}
