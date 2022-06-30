import UIKit

class ShowDetailBookViewController: UIViewController {
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        
        // FIXME: - 데이터주고받을때 completion 수정하기
        label.text = "Microsoft Office Inside Out"
        
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let detailBookView: DetailBookView = {
        let view = DetailBookView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        self.view.addConstraints([
            self.bookTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.bookTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.bookTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.scrollView.topAnchor.constraint(equalTo: self.bookTitleLabel.bottomAnchor, constant: 20),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
        ])
        
        let contentViewCenterY = self.detailBookView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        self.scrollView.addConstraints([
            self.detailBookView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.detailBookView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.detailBookView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.detailBookView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            self.detailBookView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
        ])
    }
}
