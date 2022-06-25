//
//  CompletedTaskViewController.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/26.
//

import UIKit
import SnapKit

class CompletedTaskViewController: UIViewController{
    var tableView = UITableView()
    var tagLabel = UILabel()
    var titleLabel = UILabel()
    var timeLabel = UILabel()
    var cameraView = UIImageView()
    var cameraImg = UIImageView()
    var naviView = UIView()
    var taskTitle = ""
    
    let labelArr = [
        "2022년 1월 3일 완료",
        "2022년 2월 22일 완료",
        "2022년 4월 7일 완료"
    ]
    
    let imgArr = [
        UIImage(named: "dummy_clean")!,
        UIImage(named: "dummy_wash")!,
        UIImage(named: "dummy_fridge")!
    ] as [Any]
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        setTableView()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    //MARK: UI
    func setNaviBar(){
        self.view.backgroundColor = .white
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
            $0.text = "테스크 완료기록"
        }
        naviView.addSubview(naviTitle)
        naviTitle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        let naviBtn = UIButton().then{
            $0.setImage(UIImage(named: "icon_back"), for: .normal)
        }
        naviView.addSubview(naviBtn)
        naviBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(19)
            $0.height.equalTo(12)
            $0.width.equalTo(6)
        }
        naviBtn.addTarget(self, action: #selector(clickedBackBtn), for: .touchUpInside)
    }
    
    func setTableView(){
        tableView = UITableView().then {
            $0.separatorStyle = .none
            $0.rowHeight = UITableView.automaticDimension
        }

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(naviView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
    }
    //MARK: Function
    @objc func clickedBackBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension CompletedTaskViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: UIITableView DataSource, Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            // 태그 라벨
            tagLabel = UILabel().then{
                $0.layer.cornerRadius = 10
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.mainGreen.cgColor
                $0.font = UIFont.systemFont(ofSize: 12)
                $0.text = "납부"
                $0.textAlignment = .center
                $0.textColor = .mainGreen
            }
            
            cell.addSubview(tagLabel)
            tagLabel.snp.makeConstraints{
                $0.top.equalToSuperview().inset(30)
                $0.leading.equalTo(22)
                $0.height.equalTo(21)
                $0.width.equalTo(40)
            }
            
            // 할일 제목
            titleLabel = UILabel().then{
                $0.text = taskTitle
                $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                $0.textColor = .black
            }
            cell.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(tagLabel.snp.bottom).offset(30)
                $0.trailing.equalToSuperview().inset(82)
                $0.leading.equalToSuperview().inset(18)
                $0.height.equalTo(20)
            }
            
            timeLabel = UILabel().then{
                $0.text = "2시간 소요"
                $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                $0.textColor = .black
            }
            cell.addSubview(timeLabel)
            timeLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(3)
                $0.leading.equalTo(titleLabel.snp.leading)
                $0.height.equalTo(20)
            }
            return cell
        }else{
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            
            // 날짜 뷰
            let leftDivideView = UIView().then{
                $0.backgroundColor = .gray
            }
            
            let dateLabel = UILabel().then{
                $0.font = UIFont.systemFont(ofSize: 12)
                $0.textColor = .black
                $0.text = labelArr[indexPath.row - 1]
                $0.textAlignment = .center
            }
            
            let rightDivideView = UIView().then{
                $0.backgroundColor = .gray
            }
            cell.addSubview(leftDivideView)
            cell.addSubview(dateLabel)
            cell.addSubview(rightDivideView)
            
            dateLabel.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(12)
                $0.height.equalTo(15)
                $0.width.equalTo(110)
            }
            
            leftDivideView.snp.makeConstraints{
                $0.leading.equalToSuperview().inset(22)
                $0.trailing.equalTo(dateLabel.snp.leading).offset(-19)
                $0.centerY.equalTo(dateLabel.snp.centerY)
                $0.height.equalTo(1)
            }
            
            rightDivideView.snp.makeConstraints{
                $0.trailing.equalToSuperview().inset(22)
                $0.leading.equalTo(dateLabel.snp.trailing).offset(19)
                $0.centerY.equalTo(dateLabel.snp.centerY)
                $0.height.equalTo(1)
            }
            
            // 카메라 뷰
            cameraView = UIImageView().then{
                $0.backgroundColor = .clear
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.layer.borderWidth = 1
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = true
                $0.image = imgArr[indexPath.row - 1] as! UIImage
            }
            cell.addSubview(cameraView)
            cameraView.snp.makeConstraints {
                $0.top.equalTo(dateLabel.snp.bottom).offset(19)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(UIScreen.main.bounds.size.width - 40)
            }
            
            // 카메라 이미지
            cameraImg = UIImageView().then{
                $0.image = UIImage(named: "icon_camera")
            }
            
            cell.addSubview(cameraImg)
            cameraImg.snp.makeConstraints {
                $0.centerX.equalTo(cameraView.snp.centerX)
                $0.centerY.equalTo(cameraView.snp.centerY)
                $0.height.width.equalTo(87)
            }
            cell.bringSubviewToFront(cameraView)
            return cell
        }
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier, for: indexPath) as? AlarmTableViewCell else {
    }
    
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 128
        }else{
            return 387
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
