import UIKit


final class RestTimeLabel: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let timeStack = makeHorizontalStack(views: [timeHourLabel, timeHourImgView, timeMinuteLabel, timeMinuteImgView], spacing: 1)
        
        let stackView = makeHorizontalStack(views: [timeStack, label], spacing: 2)
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func makeHorizontalStack(views: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = spacing
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }

    private let timeHourImgView: UIImageView = {
        let image = UIImage(named: "icon_hour")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timeHourLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let timeMinuteImgView: UIImageView = {
        let image = UIImage(named: "icon_minute")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timeMinuteLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "남았어요"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
}
