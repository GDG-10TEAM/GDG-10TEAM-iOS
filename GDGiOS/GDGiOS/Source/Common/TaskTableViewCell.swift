import UIKit
import SnapKit



class TableViewController: UIViewController {
    private let dummy = ["냉장고 정리", "재활용 쓰레기 버리기", "바닥 닦기", "창문 청소", "먼지 쓸기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "taskCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        return cell
    }
}



//MARK: - TaskTableViewCell
class TaskTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupLayout() {
        backgroundColor = .white
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 10
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = true
        
        addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        shadowView.backgroundColor = .white
        shadowView.addShadow(offset: CGSize(width: 4, height: 4), opacity: 0.5)
        
        addSubview(contentsView)
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(shadowView)
        }
        
        contentsView.addSubview(thumbnailImage)
        thumbnailImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.width.height.equalTo(50)
        }
        
//        let textStackView = UIStackView(arrangedSubviews: [])
    }
    
    private let contentsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
}


// ## Use ##
// emptyView.layer.borderWidth = 1
// emptyView.addShadow(location: .right)
extension UIView {
    enum VerticalLocation {
        case bottom
        case top
        case left
        case right
    }

    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.8, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -10, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 10, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
