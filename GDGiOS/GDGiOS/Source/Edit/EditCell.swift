//
//  EditCell.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import UIKit

protocol EditCellDelegate: AnyObject {
    func didTouchEdit()
}

final class EditCell: UITableViewCell {
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editSwitch: UISwitch!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var editLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    weak var delegate: EditCellDelegate?
    
    static let identifier = "EditCell"
    
    func display(cellData: EditCellModel) {
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.masksToBounds = false
        self.mainView.clipsToBounds = true
        
        self.footerView.layer.cornerRadius = 10
        self.footerView.layer.masksToBounds = false
        self.footerView.clipsToBounds = true
        
        self.titleLabel.text = cellData.title

        let color = cellData.calendarTaskModel.color

        self.footerView.backgroundColor = color
    }
    
    @IBAction func editAction(_ sender: Any) {
        self.delegate?.didTouchEdit()
    }
}
