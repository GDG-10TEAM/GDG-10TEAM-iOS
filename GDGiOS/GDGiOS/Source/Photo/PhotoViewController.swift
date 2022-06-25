//
//  PhotoViewController.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/25.
//

import Foundation
import UIKit
import SnapKit
import MobileCoreServices

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // UIImagePickerController의 인스턴스 변수
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 사진 저장 변수
    var captureImage: UIImage!
    // 사진 저장 여부
    var flagImageSave = false
    var statusBarView: UIView!

    var naviView = UIView()
//    let selectedStackView = TopTabBarView(selectedIndex: 0)
    
    var titleLabel = UILabel()
    var timeLabel = UILabel()
    var timeHourImg = UIImageView()
    var timeHourLabel = UILabel()
    var timeMinuteImg = UIImageView()
    var timeMinuteLabel = UILabel()
    
    var cameraView = UIImageView()
    var cameraBtn =  UIButton()
    var cameraImg = UIImageView()
    var tagLabel = UILabel()
    
    var nextPageBtn = UIButton()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviBar()
        initStatusBar()
        initUIComponent()
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
    func initNaviBar(){
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
            $0.text = "테스크 완료하기"
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
            $0.width.equalTo(5)
        }
        naviBtn.addTarget(self, action: #selector(clickedBackBtn), for: .touchUpInside)
    }
    
    func initStatusBar(){
        self.view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            let statusBarFrame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame
            statusBarView = UIView(frame: statusBarFrame ?? .zero)
            self.view.addSubview(statusBarView)
        } else {
            statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
        }
        statusBarView?.backgroundColor = .white
    }
    
    func initUIComponent(){
//        self.view.addSubview(selectedStackView)
//        selectedStackView.snp.makeConstraints {
//            $0.top.equalTo(naviView.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(42)
//        }
//
//        for subview in selectedStackView.btnStackView.arrangedSubviews {
//            (subview as! UIButton).addTarget(self, action: #selector(clickedTopTabBarBtn), for: .touchUpInside)
//        }
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
        
        self.view.addSubview(tagLabel)
        tagLabel.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom).offset(30)
            $0.leading.equalTo(22)
            $0.height.equalTo(21)
            $0.width.equalTo(40)
        }
        
        // 할일 제목
        titleLabel = UILabel().then{
            $0.text = "할일 제목입니다."
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .black
        }
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(30)
            $0.trailing.equalToSuperview().inset(82)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(20)
        }
        
        // 할일 시간
        
        timeHourImg = UIImageView().then{
            $0.image = UIImage(named: "icon_hour")
        }
        timeHourLabel = UILabel().then{
            $0.text = "2"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        timeMinuteImg = UIImageView().then{
            $0.image = UIImage(named: "icon_minute")
        }
        timeMinuteLabel = UILabel().then{
            $0.text = "23"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        
        self.view.addSubview(timeHourImg)
        self.view.addSubview(timeHourLabel)
        self.view.addSubview(timeMinuteImg)
        self.view.addSubview(timeMinuteLabel)
        timeHourLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(20)
        }
        timeHourImg.snp.makeConstraints {
            $0.leading.equalTo(timeHourLabel.snp.trailing).offset(1)
            $0.centerY.equalTo(timeHourLabel.snp.centerY)
            $0.height.width.equalTo(11)
        }
        timeMinuteLabel.snp.makeConstraints {
            $0.leading.equalTo(timeHourImg.snp.trailing).offset(3)
            $0.centerY.equalTo(timeHourLabel.snp.centerY)
            $0.height.equalTo(20)
        }
        timeMinuteImg.snp.makeConstraints {
            $0.leading.equalTo(timeMinuteLabel.snp.trailing).offset(1)
            $0.centerY.equalTo(timeHourLabel.snp.centerY)
            $0.height.width.equalTo(11)
        }
        
        timeLabel = UILabel().then{
            $0.text = "할일 서브."
            $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            $0.textColor = .black
        }
        self.view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(timeMinuteImg.snp.trailing).offset(1)
            $0.height.equalTo(20)
        }
        
        // 카메라 뷰
        cameraView = UIImageView().then{
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
        }
        self.view.addSubview(cameraView)
        cameraView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(UIScreen.main.bounds.size.width - 40)
        }
        
        // 카메라 이미지
        cameraImg = UIImageView().then{
            $0.image = UIImage(named: "icon_camera")
        }
        
        self.view.addSubview(cameraImg)
        cameraImg.snp.makeConstraints {
            $0.centerX.equalTo(cameraView.snp.centerX)
            $0.centerY.equalTo(cameraView.snp.centerY)
            $0.height.width.equalTo(87)
        }
        self.view.bringSubviewToFront(cameraView)
        
        // 인증 버튼
        cameraBtn = UIButton().then{
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .black
            $0.setTitle("인증하기", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.setTitleColor(UIColor.white, for: .normal)
        }
        self.view.addSubview(cameraBtn)
        cameraBtn.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        cameraBtn.addTarget(self, action: #selector(btnCaptureImageFromCamera(_:)), for: .touchUpInside)
        
        //
        nextPageBtn = UIButton().then{
            $0.setTitle("완료기록 보러가기 >", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            $0.setTitleColor(UIColor.black, for: .normal)
        }
        self.view.addSubview(nextPageBtn)
        nextPageBtn.snp.makeConstraints {
            $0.top.equalTo(cameraBtn.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(20)
        }
        nextPageBtn.addTarget(self, action: #selector(clickedNextPageBtn(_:)), for: .touchUpInside)
    }
    
    //MARK: Function
    
    @objc func clickedNextPageBtn(_ sender: UIButton){
        //TODO: 다음 페이지로
    }
    
    @objc func clickedBackBtn(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickedTopTabBarBtn(_ sender: UIButton){
//        selectedStackView.changeView(selectedIndex: sender.tag)
//        switch sender.tag {
//        case 0: selectedStackView.changeView(selectedIndex: sender.tag)
//        case 1: print("빨래")
//        case 2: print("주방")
//        case 3: print("화장실")
//        case 4: print("공과금")
//        default: break
//            
//        }
    }
    @objc func btnCaptureImageFromCamera(_ sender: UIButton){
        // 카메라의 사용 가능 여부 확인
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
 
    // 사진 선택 완료
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
       
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            cameraView.image = captureImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사진 선택 취소
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 경고 창 출력 함수
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default , handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}



