import UIKit

import SnapKit

import Then

class SearchBookTableViewCell: UITableViewCell {
    // MARK: - stored properties
    static let identifier = "SearchBookTableViewCell"
    
    lazy var searchBookView = SearchBookView()
    
    // MARK: - initialize methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.searchBookView)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError(#function)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.searchBookView.titleLabel.text = nil
        self.searchBookView.subtitleLabel.text = nil
        self.searchBookView.isbn13Label.text = nil
        self.searchBookView.priceLabel.text = nil
        self.searchBookView.urlLinkLabel.text = nil
        self.searchBookView.imageView.image = nil
    }
}

// MARK: - set up view
extension SearchBookTableViewCell {
    func setupView() {
        self.searchBookView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - methods
extension SearchBookTableViewCell {
    func configureView(by viewModel: BookItem?) {
        self.searchBookView.titleLabel.text = viewModel?.title ?? ""
        self.searchBookView.subtitleLabel.text = viewModel?.subtitle ?? ""
        self.searchBookView.isbn13Label.text = viewModel?.isbn13 ?? ""
        self.searchBookView.priceLabel.text = viewModel?.price ?? ""
        self.searchBookView.urlLinkLabel.text = viewModel?.url ?? ""
        
        if let url = URL(string: viewModel?.image ?? "") {
            if let imageData = try? Data(contentsOf: url) {
                self.searchBookView.imageView.image = UIImage(data: imageData)
            }
        }
    }
}

