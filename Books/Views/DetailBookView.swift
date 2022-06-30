import UIKit

import SnapKit

class DetailBookView: UIView {
    
    let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        return stackView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjfsldkjflsjdflskjdflksdjlfskjdlkfsldfjslsldfslkdfjlsdkjflskdjlfk"
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "asdfsflejfw;oijowjdofwijdoifwoidfo"
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "aslkdfjasalksdjflskjdlfsjdlkfsjdlkfjslkdfdf;lkdjf"
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "aslkdfjas;lalsdjflskdjflsjdlfsdflsdflskdfdfkdjf"
        return label
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .systemBlue
        label.text = "aslkdfjlskjflskjdlfkalsdfjlsdjfslkdfldjdlfkjsldkfjlskdflsdkflsdfas;lkdjf"
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "메모를 입력해보세요"
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLayout()
    }
}

extension DetailBookView {
    func setupLayout() {
        self.backgroundColor = .white

        self.addSubview(self.boxView)
        self.addSubview(self.stackView)
        self.addSubview(self.textView)
        
        self.boxView.addSubview(self.imageView)
        
        self.stackView.addArrangedSubview(self.label1)
        self.stackView.addArrangedSubview(self.label2)
        self.stackView.addArrangedSubview(self.label3)
        self.stackView.addArrangedSubview(self.label4)
        self.stackView.addArrangedSubview(self.label5)
        
        self.boxView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        self.imageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalTo(self.boxView.snp.centerX)
            $0.top.equalTo(self.boxView).offset(30)
            $0.bottom.equalTo(self.boxView).offset(-30)
        }
        
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.boxView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        self.textView.snp.makeConstraints {
            $0.top.equalTo(self.stackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(230)
        }
    }
}

