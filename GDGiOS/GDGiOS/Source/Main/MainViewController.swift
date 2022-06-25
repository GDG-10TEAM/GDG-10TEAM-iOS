//
//  ViewController.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/25.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {

    enum SectionType: Int {
        case welcome = 0
        case activeTasks
        case doneTasks
        
        var title: String? {
            switch self {
            case .welcome: return nil
            case .activeTasks: return "오늘의 테스크가 24%남았어요!"
            case .doneTasks: return "완료된 테스크"
            }
        }
    }
    
    private let sections: [SectionType] = [
        .welcome,
        .activeTasks,
        .doneTasks
    ]
    
    private let dummy: [SectionType: [DummyModel]] = [
        .welcome: [.init(title: "", progress: 0.0)],
            .activeTasks: [
                .init(title: "냉장고 정리", progress: 1.0),
                .init(title: "재활용 쓰레기 버리기", progress: 0.1),
                .init(title: "바닥 닦기", progress: 0.7),
            ],
            .doneTasks: [
                .init(title: "창문 청소", progress: 0.3),
                .init(title: "먼지 쓸기", progress: 0.5)
            ]
            
        ]
    
    private let topMenuView = TopTabBarView(selectedIndex: 0)
    private var naviView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviBar()
        setupViews()
    }
    
    @objc func touchedEditButton() {
        print("move edit page")
    }
    
    @objc func clickedTopTabBarBtn(_ sender: UIButton){
        topMenuView.changeView(selectedIndex: sender.tag)
        print("menu touched: ", sender.tag)
    }
    
    private func initNaviBar(){
        naviView = UIView().then{
            $0.backgroundColor = .white
        }
        self.view.addSubview(naviView)
        naviView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(50)
        }
        let naviTitle = UILabel().then{
            $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
            $0.text = "LOGO"
        }
        naviView.addSubview(naviTitle)
        naviTitle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func setupViews() {
        self.view.addSubview(topMenuView)
        topMenuView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }

        for subview in topMenuView.btnStackView.arrangedSubviews {
            (subview as! UIButton).addTarget(self, action: #selector(clickedTopTabBarBtn), for: .touchUpInside)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topMenuView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.register(HomeTitleCell.self, forCellReuseIdentifier: HomeTitleCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
}


// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let sectionType = SectionType(rawValue: indexPath.section), sectionType == .welcome {
            return 200
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                print("delete: ", indexPath.row)
//                dummyData.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dummy.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {
            return 0
        }
        return dummy[sectionType]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section),
              let sectionData = dummy[sectionType] else {
            return UITableViewCell()
        }
        
        switch sectionType {
        case .welcome:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTitleCell.identifier, for: indexPath) as? HomeTitleCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.titleView.editButton.addTarget(self, action: #selector(touchedEditButton), for: .touchUpInside)
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case .activeTasks,.doneTasks:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            let data = sectionData[indexPath.row]
            cell.updateViews(title: data.title, progress: data.progress)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionType(rawValue: section)?.title
    }
}
