//
//  EditViewController.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class EditViewController: BaseViewController {
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var editTableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    let selectedStackView = TopTabBarView(selectedIndex: 0)
    
    var cellDataSource: [EditCellDataSource] = []
    
    private var _cellDataSource = BehaviorSubject<[EditCellDataSource]>(value: [])
    private var dataSourceDriver: Driver<[EditCellDataSource]>?
    
    static func editInitializer(
        viewController: UIViewController
    ) {
        let storyboard = UIStoryboard(name: StoryBoard.edit, bundle: .main)
        guard let calendarDetailViewController = storyboard.instantiateViewController(withIdentifier: Self.className) as? EditViewController else { return }
        
        viewController.navigationController?.pushViewController(
            calendarDetailViewController, animated: true
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        let backBtn = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(backBarButtonTap))
        backBtn.title = ""
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func _makeMockData() {
        self._cellDataSource.onNext([EditCellDataSource(
            items: [
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                ),
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                ),
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                ),
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                ),
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                )
                ,
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                )
                ,
                EditCellModel(
                    identity: UUID().uuidString,
                    title: "냉장고 재고정리",
                    calendarTaskModel: .kitchen
                )],
            identity: UUID().uuidString)])
    }
    
    private func configureView() {
        self.navigationController?.navigationBar.tintColor = .darkGray
        self.title = "테스크 수정하기"
    
        
        self.view.addSubview(selectedStackView)
        selectedStackView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        for subview in selectedStackView.btnStackView.arrangedSubviews {
            (subview as! UIButton).addTarget(self, action: #selector(clickedTopTabBarBtn), for: .touchUpInside)
        }
        
        self.completeButton.layer.cornerRadius = 15
        self.completeButton.layer.masksToBounds = false
        self.completeButton.clipsToBounds = true
        
        self.view.setNeedsLayout()
        
        self.editTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        self.dataSourceDriver = _cellDataSource.asDriver(onErrorJustReturn: [])

        self.bind()
        self.dataSource()

        self._makeMockData()
    }
    
    @objc func clickedTopTabBarBtn(_ sender: UIButton){
        selectedStackView.changeView(selectedIndex: sender.tag)
    }
    
    @objc func backBarButtonTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func dataSource() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<EditCellDataSource> {
            dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "EditCell",
                for: indexPath
            ) as? EditCell else { return UITableViewCell() }
            
            cell.delegate = self
            cell.display(cellData: item)
            
            return cell
        }
        
        dataSource.animationConfiguration = AnimationConfiguration(
            insertAnimation: .fade,
            reloadAnimation: .fade,
            deleteAnimation: .fade
        )
        
        dataSourceDriver?
            .drive(editTableView.rx.items(dataSource: dataSource))
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


extension EditViewController: EditCellDelegate {
    func didTouchEdit() {
        TaskEditViewController.taskEditInitializer(viewController: self)
    }
}
