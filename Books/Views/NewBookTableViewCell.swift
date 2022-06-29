import UIKit

class NewBookTableViewCell: UITableViewCell {
    static let identifier = "NewBookTableViewCell"
    
    let newBookView: NewBookView = {
        let view = NewBookView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.newBookView)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError(#function)
    }
    
//    override func prepareForReuse() {}
}

extension NewBookTableViewCell {
    func setupView() {
        self.contentView.addConstraints([
            self.newBookView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.newBookView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.newBookView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.newBookView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
}
