import UIKit
import SnapKit
import Gifu

final class HomeTitleCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleView = HomeTitleView()
    
    private func setupViews() {
        self.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


final class HomeTitleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private func setupViews() {
        let imageView = GIFImageView()
        imageView.animate(withGIFNamed: "img-home") // 재생시작
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(titleLabel)
        addSubview(editButton)
        
        let sideMargin = 22
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(sideMargin)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.right.equalToSuperview().inset(sideMargin)
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = """
오늘의 집생을
시작해 볼까요
"""
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
}

//final class EditButton: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
