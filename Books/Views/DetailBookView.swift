import UIKit

class DetailBookView: UIView {
    
    let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        return stackView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjfsldkjflsjdflskjdflksdjlfskjdlkfsldfjslsldfslkdfjlsdkjflskdjlfk"
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = nil
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "aslkdfjasalksdjflskjdlfsjdlkfsjdlkfjslkdfdf;lkdjf"
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "aslkdfjas;lalsdjflskdjflsjdlfsdflsdflskdfdfkdjf"
        return label
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .systemBlue
        label.text = "aslkdfjlskjflskjdlfksjdlfkjsldkfjlskdflsdkflsdfas;lkdjf"
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "메모를 입력해보세요"
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
        self.stackView.addArrangedSubview(self.label1)
        self.stackView.addArrangedSubview(self.label2)
        self.stackView.addArrangedSubview(self.label3)
        self.stackView.addArrangedSubview(self.label4)
        self.stackView.addArrangedSubview(self.label5)
        
        self.addConstraints([
            self.imageView.widthAnchor.constraint(equalToConstant: 100),
            
            // FIXME: - 데이터 받으면 없애기
            self.imageView.heightAnchor.constraint(equalToConstant: 100),
            //
            
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.stackView.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 40),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}

