import UIKit

import SnapKit

class SearchBookView: UIView {

    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var stackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 5
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.text = nil
    }
    
    lazy var subtitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.text = nil
    }
    
    lazy var isbn13Label = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.text = nil
    }
    
    lazy var priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.text = nil
    }
    
    lazy var urlLinkLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.textColor = .systemBlue
        $0.text = nil
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
            $0.height.equalTo(130)
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
