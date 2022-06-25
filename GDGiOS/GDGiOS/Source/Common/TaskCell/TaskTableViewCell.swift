import UIKit
import SnapKit


fileprivate struct DummyModel {
    let title: String
    let progress: CGFloat
}

class TableViewController: UIViewController {
    
    private let dummy: [DummyModel] = [
            .init(title: "냉장고 정리", progress: 1.0),
            .init(title: "재활용 쓰레기 버리기", progress: 0.1),
            .init(title: "바닥 닦기", progress: 0.7),
            .init(title: "창문 청소", progress: 0.3),
            .init(title: "먼지 쓸기", progress: 0.5)
        ]
    
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
        let data = dummy[indexPath.row]
        cell.updateViews(title: data.title, progress: data.progress)
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

    func updateViews(title: String, progress: CGFloat) {
        self.titleLabel.text = title
        progressBar.updateView(value: progress)
    }
    
    private func setupLayout() {
        backgroundColor = .white

        addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(14)
        }
        shadowView.backgroundColor = .white
        shadowView.addShadow(offset: CGSize(width: 0, height: 0), opacity: 0.5, radius: 6.0)
        
        addSubview(contentsView)
        contentsView.backgroundColor = .green
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(shadowView).inset(-4)
        }
        contentsView.layer.cornerRadius = 10
        contentsView.layer.masksToBounds = true
        
        contentsView.addSubview(thumbnailImage)
        thumbnailImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.width.height.equalTo(50)
        }
        
        let descriptionStackView = makeStackView(views: [descriptionLabel, timeLabel], axis: .horizontal)
        
        let textContainerView = makeStackView(views: [descriptionStackView, titleLabel], axis: .vertical)
        contentsView.addSubview(textContainerView)
        textContainerView.snp.makeConstraints { make in
            make.left.equalTo(thumbnailImage.snp.right).offset(16)
            make.center.equalToSuperview()
        }
        
        
        contentsView.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    
    
    private func makeStackView(views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        return stackView
    }
    
    private let progressBar = ProgressBarView()
    
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
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "0번째 실행중이예요:)"
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1시간 소요"
        label.textAlignment = .left
        return label
    }()
}


// ## Use ##
// emptyView.layer.borderWidth = 1
// emptyView.addShadow(location: .right)
extension UIView {
    func addShadow(offset: CGSize = CGSize(width: 0, height: 0), color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
