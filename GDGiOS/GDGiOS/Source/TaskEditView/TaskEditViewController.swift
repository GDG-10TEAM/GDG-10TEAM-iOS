//
//  TaskEditViewController.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/25.
//

import UIKit

protocol TaskEditViewControllerDelegate: AnyObject {
    
}

enum TaskEditPickerType {
    case day, count, time
}

final class TaskEditViewController: BaseViewController {
    @IBOutlet weak var taskEditView: UIView!
    @IBOutlet weak var taskStoreButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayTaskButton: UIButton!
    @IBOutlet weak var countTaskButton: UIButton!
    @IBOutlet weak var timeTaskButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let day = ["1일", "2일", "3일", "일주일", "2주일", "한달", "두달", "세달", "반년", "열한달", "일년"]
    private let count = ["1회", "2회", "3회", "4회", "5회", "6회", "7회", "8회", "9회", "10회"]
    private let time = ["1시간", "2시간", "3시간", "4시간", "5시간", "6시간", "7시간", "8시간", "9시간", "10시간", "11시간", "12시간", "13시간", "14시간", "15시간" ,"16시간", "17시간", "18시간", "19시간", "20시간", "21시간", "22시간", "23시간"]
    
    private var pickerType: TaskEditPickerType = .day
    private var isPickerHidden = true
    
    static func taskEditInitializer(
        viewController: UIViewController
    ) {
        let storyboard = UIStoryboard(name: StoryBoard.taskEdit, bundle: .main)
        guard let taskEditViewController = storyboard.instantiateViewController(withIdentifier: Self.className) as? TaskEditViewController else { return }
        
        taskEditViewController.modalTransitionStyle = .crossDissolve
        taskEditViewController.modalPresentationStyle = .overCurrentContext
        
        viewController.present(taskEditViewController, animated: true, completion: nil)
    }
    
    weak var delegate: TaskEditViewControllerDelegate? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    private func configureView() {
        self.taskEditView.layer.cornerRadius = 15
        self.taskEditView.layer.masksToBounds = false
        self.taskEditView.clipsToBounds = true
        
        self.taskStoreButton.layer.cornerRadius = 10
        self.taskStoreButton.layer.masksToBounds = false
        self.taskStoreButton.clipsToBounds = true
        
        self.pickerView.layer.cornerRadius = 15
        self.pickerView.layer.masksToBounds = false
        self.pickerView.clipsToBounds = true
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    @objc private func cancelAction() {
        self.dismiss(animated: true)
    }
    
    @IBAction func taskStoreAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dayTaskAction(_ sender: Any) {
        if !isPickerHidden {
            UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: { [weak self] in
                self?.pickerView.isHidden = true
                self?.isPickerHidden = true
            })
            return
        }
        
        self.pickerType = .day
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: { [weak self] in
            self?.pickerView.isHidden = false
            self?.isPickerHidden = false
        })
    }
    
    @IBAction func countTaskAction(_ sender: Any) {
        if !isPickerHidden {
            UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: { [weak self] in
                self?.pickerView.isHidden = true
                self?.isPickerHidden = true
            })
            return
        }
        
        self.pickerType = .count
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: { [weak self] in
            self?.pickerView.isHidden = false
            self?.isPickerHidden = false
        })
    }
    
    @IBAction func timeTaskAction(_ sender: Any) {
        if !isPickerHidden {
            UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: { [weak self] in
                self?.pickerView.isHidden = true
                self?.isPickerHidden = true
            })
            return
        }
        
        self.pickerType = .time
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .showHideTransitionViews, animations: { [weak self] in
            self?.pickerView.isHidden = false
            self?.isPickerHidden = false
        })
    }
}

extension TaskEditViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        rowHeightForComponent: Int
    ) -> CGFloat {
        return 50
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int
    ) -> NSAttributedString? {
        var attributedKeys = [NSAttributedString.Key: Any]()
        attributedKeys.updateValue(
            UIFont.systemFont(ofSize: 17, weight: .semibold) as Any,
            forKey: .font
        )
        attributedKeys.updateValue(UIColor.black, forKey: .foregroundColor)
        
        switch self.pickerType {
        case .day:
            return NSAttributedString(string: day[row], attributes: attributedKeys)
        case .count:
            return NSAttributedString(string: count[row], attributes: attributedKeys)
        case .time:
            return NSAttributedString(string: time[row], attributes: attributedKeys)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.pickerType {
        case .day:
            return self.day.count
        case .count:
            return self.count.count
        case .time:
            return self.time.count
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        var pickerLabel : UILabel
        if let label = view as? UILabel {
            pickerLabel = label
        } else {
            pickerLabel = UILabel()
            pickerLabel.textColor = UIColor.white
            pickerLabel.textAlignment = NSTextAlignment.center
            pickerLabel.sizeToFit()
        }
        
        pickerLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        switch self.pickerType {
        case .day:
            pickerLabel.text = self.day[row]
        case .count:
            pickerLabel.text = self.count[row]
        case .time:
            pickerLabel.text = self.time[row]
        }
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let label = pickerView.view(forRow: row, forComponent: 0) as? UILabel {
            label.font = .systemFont(ofSize: 17, weight: .semibold)
        }
        
        switch self.pickerType {
        case .day:
            print(self.day[row])
        case .count:
            print(self.count[row])
        case .time:
            print(self.time[row])
        }
    }
}
