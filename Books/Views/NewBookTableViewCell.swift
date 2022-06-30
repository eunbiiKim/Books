import UIKit

import SnapKit

class NewBookTableViewCell: UITableViewCell {
    static let identifier = "NewBookTableViewCell"
    
    let newBookView: NewBookView = {
        let view = NewBookView()
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
        self.newBookView.snp.makeConstraints {
            $0.top.equalTo(super.contentView).offset(10)
            $0.leading.equalTo(super.contentView).offset(20)
            $0.trailing.equalTo(super.contentView).offset(-20)
            $0.bottom.equalTo(super.contentView).offset(-10)
        }
    }
}
