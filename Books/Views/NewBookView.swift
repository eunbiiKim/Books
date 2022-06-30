import UIKit

import SnapKit

class NewBookView: UIView {
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    let bottomLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjfsldkjflsjdflskjdflksdjlfskjdlkfsldfjslsldfslkdfjlsdkjflskdjlfk"
        return label
    }()
    
    let bottomLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjf"
        return label
    }()
    
    let bottomLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "aslkdfjas;lkdjf"
        return label
    }()
    
    let bottomLabel4: UILabel = {
        let label = UILabel()
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

extension NewBookView {
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
        
        self.topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.bottomView.snp.makeConstraints {
            $0.top.equalTo(self.topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    
        self.topImageView.snp.makeConstraints {
            $0.top.equalTo(self.topView).offset(25)
            $0.bottom.equalTo(self.topView).offset(-25)
            // FIXME: - 데이터 받으면
            $0.width.equalTo(100)
            $0.height.equalTo(140)
            //
            $0.centerX.equalTo(self.topView)
        }
        
        self.bottomStackView.snp.makeConstraints {
            $0.top.equalTo(self.bottomView).offset(15)
            $0.leading.equalTo(self.bottomView).offset(20)
            $0.trailing.equalTo(self.bottomView).offset(-20)
            $0.bottom.equalTo(self.bottomView).offset(-15)
        }
    }
}
