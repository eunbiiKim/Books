import UIKit

class SearchBookTableViewCell: UITableViewCell {
    static let identifier = "SearchBookTableViewCell"
    
    let searchBookView: SearchBookView = {
        let view = SearchBookView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        self.contentView.addConstraints([
            self.searchBookView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.searchBookView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.searchBookView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.searchBookView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
