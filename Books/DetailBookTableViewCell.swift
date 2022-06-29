import UIKit

class DetailBookTableViewCell: UITableViewCell {
    static let identifier = "DetailBookTableViewCell"
    
    let detailBookView: DetailBookView = {
        let view = DetailBookView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.detailBookView)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError(#function)
    }
    
//    override func prepareForReuse() {}
}

extension DetailBookTableViewCell {
    func setupView() {
        self.contentView.addConstraints([
            self.detailBookView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.detailBookView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.detailBookView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.detailBookView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
}
