import UIKit

import SnapKit

import Then

class DetailBookView: UIView {
    // MARK: - stored properties
    lazy var boxView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var stackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 6
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = nil
    }
    
    lazy var subtitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = nil
    }
    
    lazy var isbn13Label = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = nil
    }
    
    lazy var priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = nil
    }
    
    lazy var urlLinkLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.textColor = .systemBlue
        $0.text = nil
    }
    
    lazy var textView = UITextView().then {
        $0.text = "메모를 입력해보세요"
        $0.textColor = .systemGray3
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    // MARK: - initialize methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

// MARK: - set up view methods
extension DetailBookView {
    func setupView() {
        self.backgroundColor = .white

        self.addSubview(self.boxView)
        self.addSubview(self.stackView)
        self.addSubview(self.textView)
        
        self.boxView.addSubview(self.imageView)
        
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.subtitleLabel)
        self.stackView.addArrangedSubview(self.isbn13Label)
        self.stackView.addArrangedSubview(self.priceLabel)
        self.stackView.addArrangedSubview(self.urlLinkLabel)
        
        self.boxView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        self.imageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalTo(self.boxView.snp.centerX)
            $0.top.bottom.equalTo(self.boxView).inset(30)
        }
        
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.boxView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.textView.snp.makeConstraints {
            $0.top.equalTo(self.stackView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(230)
        }
    }
}

// MARK: - methods
extension DetailBookView {
    func configureView(with bookModel: BookModel) {
        guard let url = URL(string: bookModel.image ?? "") else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        self.imageView.image = UIImage(data: imageData)
        
        self.titleLabel.text = bookModel.title ?? ""
        self.subtitleLabel.text = bookModel.subtitle ?? ""
        self.isbn13Label.text = bookModel.isbn13 ?? ""
        self.priceLabel.text = bookModel.price ?? ""
        self.urlLinkLabel.text = bookModel.url ?? ""
        
        guard let bookTitle = bookModel.title else { return }
        if let bookContext = UserDefaults.standard.string(forKey: bookTitle) {
            self.textView.text = bookContext
            self.textView.textColor = .black
        }
    }
}

extension ConstraintPriority {
    func makeSafeArea() {
        
    }
}
