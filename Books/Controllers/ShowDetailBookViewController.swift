import UIKit

import SnapKit

import Then

class ShowDetailBookViewController: UIViewController {
    // MARK: - stored properties
    lazy var bookModel: BookModel? = nil
    
    lazy var isbn13: String? = nil
    
    lazy var bookTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = nil
    }
    
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    lazy var detailBookView = DetailBookView().then {
        $0.backgroundColor = .white
    }
    
    // MARK: - view controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewLayout()
        
        self.setupView()

        self.loadData()
    }
}

// MARK: - set up view
extension ShowDetailBookViewController {
    func setupViewLayout() {
        self.view.addSubview(self.bookTitleLabel)
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.detailBookView)
        
        self.bookTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.bookTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.detailBookView.snp.makeConstraints {
            $0.top.centerX.equalTo(self.scrollView)
            $0.leading.trailing.bottom.equalTo(self.scrollView).inset(20)
            $0.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        self.detailBookView.textView.delegate = self
        
        self.detailBookView.textView.returnKeyType = .done
    }
}


extension ShowDetailBookViewController {
    // MARK: - load data
    func loadData() {
        NetworkService.shared.loadData(
            path: "books",
            query1: self.isbn13,
            query2: nil
        ) {
            self.bookModel = NetworkService.shared.bookModel
            DispatchQueue.main.async {
                self.bookTitleLabel.text = self.bookModel?.title ?? ""
                self.detailBookView.configureView(with: self.bookModel!)
            }
        }
    }
}

// MARK: - text view delegate
extension ShowDetailBookViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // FIXME: - keyboard 높이만큼 scroll view도 올라가야함 -> NotificationCenter
        if textView.textColor != .black {
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let title = self.bookModel?.title else { return }
        guard let text = textView.text else { return }
        
        if textView.textColor == .systemGray3 || text == "" {
            self.detailBookView.textView.text = "메모를 입력해보세요"
            self.detailBookView.textView.textColor = .systemGray3
            if UserDefaults.standard.string(forKey: title) != nil {
                UserDefaults.standard.removeObject(forKey: title)
            }
        } else {
            UserDefaults.standard.set(text, forKey: title)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            // MARK: - keyboard 내려갈때 scrollView도 내려가기 -> NotificationCenter
            return false
        }
        return true
    }
}
