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
    
    private var dummy: [SectionType: [MainDTO]] = [
            .welcome: [],
            .activeTasks: [],
            .doneTasks: []
        ]
    
    var currentIndex : Int {
           guard let vc = viewControllers.first else { return 0 }
           return viewControllers.firstIndex(of: vc) ?? 0
       }
    
    private let viewControllers: [UIViewController] = [DetailViewController(), DetailViewController()]
    
    private let topMenuView = TopTabBarView(selectedIndex: 0)
    private var naviView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviBar()
        setupViews()
        
        DefaultNetworkService.instance.request(
            router: MainRoutor.mainFetch
        ) { [weak self] (response: [MainDTO]) in
            print(response)
            let randomNum = Int.random(in: 1..<response.count)
            
            let front = response[0..<randomNum]
            self?.dummy[SectionType.activeTasks] = Array(front)
            
            let back = response[randomNum..<response.count]
            self?.dummy[SectionType.doneTasks] = Array(back)
            
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func touchedEditButton() {
        EditViewController.editInitializer(viewController: self)
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
        
        // 여기서 부터 페이징 함
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topMenuView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        let detailViewController = DetailViewController()
        let pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        pageViewController.setViewControllers([detailViewController], direction: .forward, animated: false)
        pageViewController.dataSource = self
//        pageViewController.delegate = self
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

// MARK: - TableViewDataSource
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
            let progress = CGFloat.random(in: 0.0..<1.0)
            cell.updateViews(title: data.name, progress: progress, category: data.category_name)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionType(rawValue: section)?.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sectionType = SectionType(rawValue: indexPath.section),
              let sectionData = dummy[sectionType]  {
            let photoVC = PhotoViewController()
            let data = sectionData[indexPath.row]
            photoVC.taskTitle = data.title
            self.navigationController?.pushViewController(photoVC, animated: true)
        }
    }
}


extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        if previousIndex < 0 { return nil}
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllers.firstIndex(of: viewController) else {return nil}
        let nextIndex = index + 1
        if nextIndex == viewControllers.count { return nil}
        return viewControllers[nextIndex]
    }
    
    
}

extension MainViewController: UIPageViewControllerDelegate {
    
    
}
