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
    
//    override func prepareForReuse() {}
}

extension NewBookTableViewCell {
    func setupView() {
        self.newBookView.snp.makeConstraints {
            $0.top.bottom.equalTo(super.contentView).inset(10)
            $0.leading.trailing.equalTo(super.contentView).inset(20)
        }
    }
}
