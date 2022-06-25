import UIKit

final class BarView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = rect.height/2
    }
}


final class ProgressBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(value: CGFloat, color: UIColor? = nil) {
        let newConstraint = widthConstraint.constraintWithMultiplier(value)
        removeConstraint(widthConstraint)
        addConstraint(newConstraint)
        bar.backgroundColor = color ?? UIColor(red: 255/255, green: 96/255, blue: 96/255, alpha: 1.0)
        layoutIfNeeded()
        widthConstraint = newConstraint
    }
    
    // MARK: - Views
    private var widthConstraint: NSLayoutConstraint!
    
    private func setupViews() {
        addSubview(backgroundBar)
        backgroundBar.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        addSubview(bar)
        bar.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(backgroundBar)
        }
        
        bar.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint = bar.widthAnchor.constraint(equalTo: backgroundBar.widthAnchor, multiplier: 1.0)
        widthConstraint.isActive = true
        
        addSubview(restTimeLabel)
        restTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
    
    private let bar: BarView = {
        let view = BarView()
        view.backgroundColor = UIColor(red: 255/255, green: 96/255, blue: 96/255, alpha: 1.0)
        return view
    }()
    
    private let backgroundBar: BarView = {
        let view = BarView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let restTimeLabel = RestTimeLabel()
}


