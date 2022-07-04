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
        self.newBookView.topImageView.image = nil
    }
}

extension NewBookTableViewCell {
    func setupCell(viewModel: [Book], row: Int) {
        self.newBookView.titleLabel.text = viewModel[row].title!
        self.newBookView.subtitleLabel.text = viewModel[row].subtitle!
        self.newBookView.priceLabel.text = viewModel[row].price!
        self.newBookView.isbn13Label.text = viewModel[row].isbn13!
        if let image = UIImage(data: viewModel[row].image!) {
            DispatchQueue.main.async {
                self.newBookView.topImageView.image = image
            }
        }
    }
    
    func setupView() {
        self.newBookView.snp.makeConstraints {
            $0.top.bottom.equalTo(super.contentView).inset(10)
            $0.leading.trailing.equalTo(super.contentView).inset(20)
        }
    }
}
