import UIKit

class DetailBookView: UIView {
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    let bottomLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjfsldkjflsjdflskjdflksdjlfskjdlkfsldfjslsldfslkdfjlsdkjflskdjlfk"
        return label
    }()
    
    let bottomLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjf"
        return label
    }()
    
    let bottomLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjf"
        return label
    }()
    
    let bottomLabel4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjf"
        return label
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
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        self.addSubview(self.topView)
        self.addSubview(self.bottomView)
        self.topView.addSubview(self.topImageView)
        self.bottomView.addSubview(self.bottomStackView)
        self.bottomStackView.addArrangedSubview(self.bottomLabel1)
        self.bottomStackView.addArrangedSubview(self.bottomLabel2)
        self.bottomStackView.addArrangedSubview(self.bottomLabel3)
        self.bottomStackView.addArrangedSubview(self.bottomLabel4)
        
        self.addConstraints([
            self.topView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomView.topAnchor.constraint(equalTo: self.topView.bottomAnchor),
            self.bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        self.topView.addConstraints([
            self.topImageView.topAnchor.constraint(equalTo: self.topView.topAnchor, constant: 25),
            self.topImageView.bottomAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: -25),
            // FIXME: - 데이터 받으면
            self.topImageView.widthAnchor.constraint(equalToConstant: 100),
            self.topImageView.heightAnchor.constraint(equalToConstant: 140),
            //
            self.topImageView.centerXAnchor.constraint(equalTo: self.topView.centerXAnchor)
        ])
        
        self.bottomView.addConstraints([
            self.bottomStackView.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 15),
            self.bottomStackView.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20),
            self.bottomStackView.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -20),
            self.bottomStackView.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -15),
        ])
    }
}
