//
//  CustomCalendarView.swift
//  CustomCalendarView
//
//  Created by 김민창 on 2022/05/03.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

protocol CustomCalenderViewDelegate: AnyObject {
    func didSelectedDate(date: Date)
    func taskCount(count: Int)
}

@IBDesignable
final class CustomCalendarView: UIView {
    private let xibName = "CustomCalendar"
    
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var beforeMonthLabel: UILabel!
    @IBOutlet weak var nextMonthLabel: UILabel!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var calendarHeightConstraints: NSLayoutConstraint!
    
    weak var delegate: CustomCalenderViewDelegate?
    
    override var bounds: CGRect {
        didSet {
            let minColumnWidth: CGFloat = self.bounds.width / 7
            self.calendarHeightConstraints.constant = (minColumnWidth - 1) * (7 / 5) * 7 + 10
        }
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var viewModel = CustomCalendarViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure(){
        guard let view = Bundle
            .main
            .loadNibNamed(xibName, owner: self, options: nil)?
            .first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        self._configureBase()
        
        self._bindCalendarCollectionView()
        self._bindYearMonthText()
        self._bindSelectedDate()
        self._bindBeforeMonthText()
        self._bindNextMonthText()
        self._bindTaskCount()
    }
    
    private func _configureBase() {
        self.calendarCollectionView.delegate = self
        CustomCalendarCell.register(to: self.calendarCollectionView)
    }
    
    @IBAction func beforeMonthAction(_ sender: Any) {
        self.viewModel.input.beforeMonth.onNext(())
    }
    
    @IBAction func nextMonthAction(_ sender: Any) {
        self.viewModel.input.nextMonth.onNext(())
    }
    
    private func _bindCalendarCollectionView() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<CustomCalendarCellDataSource>(
            configureCell: { dataSource, collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CustomCalendarCell.identifier,
                    for: indexPath
                ) as? CustomCalendarCell else { return UICollectionViewCell() }
                
                cell.display(cellModel: item)
                
                return cell
            }
        )
        
        dataSource.animationConfiguration = AnimationConfiguration(
            insertAnimation: .fade,
            reloadAnimation: .fade,
            deleteAnimation: .fade
        )
        
        self.viewModel.output.cellDataSource
            .drive(calendarCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.calendarCollectionView.rx.modelSelected(CustomCalendarCellModel.self)
            .subscribe(onNext: { [weak self] cellModel in
                self?.viewModel.input.selectedItem.onNext(cellModel)
            })
            .disposed(by: disposeBag)
    }
    
    private func _bindYearMonthText() {
        self.viewModel.output.yearMonthText
            .drive(self.yearMonthLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func _bindSelectedDate() {
        self.viewModel.output.selectedDate
            .compactMap { $0 }
            .drive(onNext: { [weak self] date in
                self?.delegate?.didSelectedDate(date: date)
            })
            .disposed(by: disposeBag)
    }
    
    private func _bindBeforeMonthText() {
        self.viewModel.output.beforeMonthText
            .drive(self.beforeMonthLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func _bindNextMonthText() {
        self.viewModel.output.nextMonthText
            .drive(self.nextMonthLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func _bindTaskCount() {
        self.viewModel.output.taskCount
            .compactMap { $0 }
            .drive(onNext: { [weak self] count in
                self?.delegate?.taskCount(count: count)
            })
            .disposed(by: disposeBag)
    }
}

extension CustomCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let minColumnWidth: CGFloat = self.bounds.width / 7
        return CGSize(width: minColumnWidth - 1, height: (minColumnWidth - 1) * (7 / 5) - 2)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 1
    }
}
