import UIKit

import SnapKit

import Then

class DetailBookView: UIView {
    
    /*
     response parameters : / 값이 없는 형태는 ""-> 빈 String
     title
     subtitle
     isbn13
     price
     image - url
     url
     */
    
    lazy var boxView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    lazy var imageView = UIImageView().then {
        $0.backgroundColor = .white
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
        $0.text = "aslkdfjas;lkdjfsldkjflsjdflskjdflksdjlfskjdlkfsldfjslsldfslkdfjlsdkjflskdjlfk"
    }
    
    lazy var subtitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "asdfsflejfw;oijowjdofwijdoifwoidfo"
    }
    
    lazy var isbn13Label = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "aslkdfjasalksdjflskjdlfsjdlkfsjdlkfjslkdfdf;lkdjf"
    }
    
    lazy var priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "aslkdfjas;lalsdjflskdjflsjdlfsdflsdflskdfdfkdjf"
    }
    
    lazy var urlLinkLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.textColor = .systemBlue
        $0.text = "aslkdfjlskjflskjdlfkalsdfjlsdjfslkdfldjdlfkjsldkfjlskdflsdkflsdfas;lkdjf"
    }
    
    lazy var textView = UITextView().then {
        $0.text = "메모를 입력해보세요"
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension DetailBookView {
    func display(title: String?, subtitle: String?, isbn13: String?, price: String?, image: String?, url: String?) {
        // 옵셔널 바인딩
    }
    
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

