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
    
    var naviView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let selectedStackView = TopTabBarView(selectedIndex: 0)
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .blue
        stackView.axis = .horizontal
        return stackView
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "할일 제목입니다."
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "할일 상세보기"
        return label
    }()
    
    let cameraView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    let cameraBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGreen
        btn.setTitle("인증하기", for: .normal)
        return btn
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initNaviBar()
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
        self.view.addSubview(naviView)
        naviView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    func initUIComponent(){
        self.view.addSubview(selectedStackView)
        selectedStackView.snp.makeConstraints { (make) in
            make.top.equalTo(naviView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(42)
        }
        
        for subview in selectedStackView.btnStackView.arrangedSubviews {
            (subview as! UIButton).addTarget(self, action: #selector(clickedTopTabBarBtn), for: .touchUpInside)
        }
        
        self.view.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(selectedStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }

        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        titleView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        self.view.addSubview(cameraView)
        cameraView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(300)
        }
        self.view.addSubview(cameraBtn)
        cameraBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cameraView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.equalTo(70)
        }
        cameraBtn.addTarget(self, action: #selector(btnCaptureImageFromCamera(_:)), for: .touchUpInside)
    }
    
    //MARK: Function
    @objc func clickedTopTabBarBtn(_ sender: UIButton){
        selectedStackView.changeView(selectedIndex: sender.tag)
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



