import UIKit

import SnapKit

class SearchBookView: UIView {
    
    /*
     response parameters : / 값이 없는 형태는 ""-> 빈 String
     total
     page
     title
     subtitle
     isbn13
     price
     image - url
     url
     */
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "aslkdfjas;lkdjfsldkjflsjdflskjdflksdjlfskjdlkfsldfjslsldfslkdfjlsdkjflskdjlfk"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = nil
        return label
    }()
    
    let isbn13Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "aslkdfjasalksdjflskjdlfsjdlkfsjdlkfjslkdfdf;lkdjf"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "aslkdfjas;lalsdjflskdjflsjdlfsdflsdflskdfdfkdjf"
        return label
    }()
    
    let urlLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .systemBlue
        label.text = "aslkdfjlskjflskjdlfksjdlfkjsldkfjlskdflsdkflsdfas;lkdjf"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension SearchBookView {
    func setupView() {
        self.backgroundColor = .white
        
        self.addSubview(self.imageView)
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.subtitleLabel)
        self.stackView.addArrangedSubview(self.isbn13Label)
        self.stackView.addArrangedSubview(self.priceLabel)
        self.stackView.addArrangedSubview(self.urlLinkLabel)
        
        self.imageView.snp.makeConstraints {
            $0.width.equalTo(100)
            // FIXME: - 데이터 받으면 없애기
            $0.height.equalTo(100)
            //
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        self.stackView.snp.makeConstraints {
            $0.centerY.equalTo(self.imageView.snp.centerY)
            $0.leading.equalTo(self.imageView.snp.trailing).offset(40)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
