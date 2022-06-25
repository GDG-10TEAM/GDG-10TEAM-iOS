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
    
    func display(cellModel: CustomCalendarCellModel) {
        self.dayLabel.text = "\(cellModel.day)"
        
        if !cellModel.isCurrentMonth {
            self.dayLabel.alpha = 0.3
        } else {
            self.dayLabel.alpha = 1.0
        }
        
        if cellModel.isSunDay {
            self.dayLabel.textColor = .systemRed
        } else {
            self.dayLabel.textColor = .label
        }
        
        if cellModel.isCurrentDay {
            self.dayLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        }
    }
}
