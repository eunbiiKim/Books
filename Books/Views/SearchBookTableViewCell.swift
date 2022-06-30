import UIKit

import SnapKit

import Then

class SearchBookTableViewCell: UITableViewCell {
    static let identifier = "SearchBookTableViewCell"
    
    lazy var searchBookView = SearchBookView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.searchBookView)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError(#function)
    }
    
//    override func prepareForReuse() {}
}

extension SearchBookTableViewCell {
    func setupView() {
        self.searchBookView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
