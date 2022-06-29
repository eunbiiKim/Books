import UIKit

class ShowDetailBookViewController: UIViewController {
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Microsoft Office Inside Out"
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemGray5
//        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.view.addSubview(self.bookTitleLabel)
        
        self.view.addSubview(self.scrollView)
        
        self.setupViewsLayout()
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        
        self.scrollView.addSubview(view)
        
        self.scrollView.addConstraints([
            view.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            view.widthAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.widthAnchor),
            view.heightAnchor.constraint(equalToConstant: 2000)
        ])
        
        self.scrollView.contentSize = CGSize(width: 300, height: 3000)
        
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
    }
}
