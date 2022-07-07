import UIKit

import SnapKit

import Then

class NoResultTableViewCell: UITableViewCell {
    // MARK: - stored properties
    static let identifier = "NoResultTableViewCell"

    // MARK: - initialize methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError(#function)
    }
}

// MARK: - methods
extension NoResultTableViewCell {
    func setupView() {
        self.contentView.backgroundColor = .white
        self.textLabel?.textColor = .systemGray3
        self.textLabel?.text = "검색 결과가 없습니다."
        
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(130)
        }
        
        self.textLabel?.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
