//
//  CustomCalendarCell.swift
//  CustomCalendarView
//
//  Created by 김민창 on 2022/05/03.
//

import UIKit

class CustomCalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    
    static let identifier = "CustomCalendarCell"
    
    static private let _nibName: UINib = UINib(nibName: CustomCalendarCell.identifier, bundle: .main)
    
    static func register(to collectionView: UICollectionView) {
        collectionView.register(
            _nibName,
            forCellWithReuseIdentifier: CustomCalendarCell.identifier
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self._configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self._configureView()
    }
    
    private func _configureView() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        self.firstStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        self.secondStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func display(cellModel: CustomCalendarCellModel) {
        self.dayLabel.text = "\(cellModel.day)"
        
        if !cellModel.isCurrentMonth {
            self.dayLabel.alpha = 0.3
            self.firstStackView.alpha = 0.3
            self.secondStackView.alpha = 0.3
        } else {
            self.dayLabel.alpha = 1.0
            self.firstStackView.alpha = 1.0
            self.secondStackView.alpha = 1.0
        }
        
        if cellModel.isSunDay {
            self.dayLabel.textColor = .systemRed
        } else {
            self.dayLabel.textColor = .label
        }
        
        self.addTaskView(calendarTaskList: [.clean, .wash, .kitchen, .friend, .payment])
    }
    
    private func addTaskView(calendarTaskList: [CalendarTaskModel]) {
        calendarTaskList.forEach {
            let view = UIView()
            switch $0 {
            case .clean:
                view.backgroundColor = UIColor.mainNavy
            case .wash:
                view.backgroundColor = UIColor.mainGray
            case .kitchen:
                view.backgroundColor = UIColor.mainRed
            case .friend:
                view.backgroundColor = UIColor.mainYellow
            case .payment:
                view.backgroundColor = UIColor.mainGreen
            }
            
            if firstStackView.subviews.count == 3 {
                secondStackView.addArrangedSubview(view)
            } else {
                firstStackView.addArrangedSubview(view)
            }
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 5),
                view.widthAnchor.constraint(equalToConstant: 5)
            ])
            
            view.layer.cornerRadius = 2.5
            view.layer.masksToBounds = false
            view.clipsToBounds = true
        }
    }
}
