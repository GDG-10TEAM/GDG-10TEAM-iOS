//
//  CalendarDetailViewController.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class CalendarDetailViewController: BaseViewController {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var calendarDetailTableView: UITableView!
    
    private var currentDay: Date = Date()
    private var dayFormatter = DateFormatter()
    
    var cellDataSource: [TaskCellDataSource] = []
    
    private var _cellDataSource = BehaviorSubject<[TaskCellDataSource]>(value: [])
    private var dataSourceDriver: Driver<[TaskCellDataSource]>?
    
    static func calendarDetailInitializer(
        viewController: UIViewController,
        currentDay: Date
    ) {
        let storyboard = UIStoryboard(name: StoryBoard.calendarDetail, bundle: .main)
        guard let calendarDetailViewController = storyboard.instantiateViewController(withIdentifier: Self.className) as? CalendarDetailViewController else { return }
        
        calendarDetailViewController.currentDay = currentDay
        
        viewController.navigationController?.pushViewController(
            calendarDetailViewController, animated: true
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.dataSourceDriver = _cellDataSource.asDriver(onErrorJustReturn: [])
        self.calendarDetailTableView.rowHeight = 110
        
        self.dataSource()
        self.bind()
        
        self._makeMockData()
    }
    
    private func _makeMockData() {
        self._cellDataSource.onNext([TaskCellDataSource(
            items: [
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "창틀 청소하기",
                    progress: 0.8,
                    calendarTaskModel: .clean
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "분리수거하기",
                    progress: 0.6,
                    calendarTaskModel: .clean
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "화장대 서랍 정리",
                    progress: 0.8,
                    calendarTaskModel: .clean
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "이부자리 정돈하기",
                    progress: 0.9,
                    calendarTaskModel: .wash
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "이부자리 정돈하기",
                    progress: 0.2,
                    calendarTaskModel: .wash
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "설거지하기",
                    progress: 0.4,
                    calendarTaskModel: .kitchen
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "가스요금 납부하기",
                    progress: 0.5,
                    calendarTaskModel: .payment
                ),
                TaskCellModel(
                    identity: UUID().uuidString,
                    title: "인터넷 요금 납부하기",
                    progress: 0.3,
                    calendarTaskModel: .payment
                )],
            identity: UUID().uuidString)])
    }
    
    private func configureView() {
        self.navigationController?.navigationBar.tintColor = .darkGray
//        self.title = "LOGO"
        self.navigationItem.title = "LOGO"
        self.dayFormatter.dateFormat = "MM.dd"
        self.calendarDetailTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        let dayString = dayFormatter.string(from: self.currentDay)
        self.dayLabel.text = dayString
    }
    
    private func dataSource() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<TaskCellDataSource> {
            dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TaskTableViewCell.identifier,
                for: indexPath
            ) as? TaskTableViewCell else { return UITableViewCell() }
            
            cell.display(cellModel: item)
            
            return cell
        }
        
        dataSource.animationConfiguration = AnimationConfiguration(
            insertAnimation: .fade,
            reloadAnimation: .fade,
            deleteAnimation: .fade
        )
        
        dataSourceDriver?
            .drive(calendarDetailTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        self._cellDataSource
            .subscribe(onNext: { [weak self] dataSource in
                self?.cellDataSource = dataSource
            })
            .disposed(by: disposeBag)
    }
}
