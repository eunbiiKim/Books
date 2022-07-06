import UIKit

import SnapKit

import Then

class NewBookTableViewCell: UITableViewCell {
    static let identifier = "NewBookTableViewCell"
    
    lazy var newBookView = NewBookView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.newBookView.titleLabel.text = nil
        self.newBookView.subtitleLabel.text = nil
        self.newBookView.priceLabel.text = nil
        self.newBookView.isbn13Label.text = nil
        self.newBookView.topImageView.image = nil
    }
}

extension NewBookTableViewCell {
    func configureCell(by bookModel: [String: String]?) {
        self.newBookView.titleLabel.text = bookModel?["title"] ?? ""
        self.newBookView.subtitleLabel.text = bookModel?["subtitle"] ?? ""
        self.newBookView.priceLabel.text = bookModel?["price"] ?? ""
        self.newBookView.isbn13Label.text = bookModel?["isbn13"] ?? ""

        DispatchQueue.main.async {
            guard let urlString = bookModel?["image"] else { return }
            guard let imageURL = URL(string: urlString) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            self.newBookView.topImageView.image = UIImage(data: imageData)
        }
    }
    
    func setupView() {        
        self.newBookView.snp.makeConstraints {
            $0.top.bottom.equalTo(super.contentView).inset(10)
            $0.leading.trailing.equalTo(super.contentView).inset(20)
        }
    }
}
