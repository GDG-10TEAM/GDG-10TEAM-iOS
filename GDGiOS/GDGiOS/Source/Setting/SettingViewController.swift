//
//  SettingViewController.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.

//case .clean:
//    return UIColor.mainNavy
//case .wash:
//    return UIColor.mainGray
//case .kitchen:
//    return UIColor.mainRed
//case .friend:
//    return UIColor.mainYellow
//case .payment:
//

import UIKit

final class SettingViewController: BaseViewController {
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var cleanView: UIView!
    @IBOutlet weak var washView: UIView!
    @IBOutlet weak var kitchenView: UIView!
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var paymentView: UIView!
    
    private var clean = true
    private var wash = true
    private var kitchen = true
    private var friend = true
    private var payment = true
    
    static func calendarDetailInitializer(
        viewController: UIViewController,
        currentDay: Date
    ) {
        let storyboard = UIStoryboard(
            name: StoryBoard.setting,
            bundle: .main
        )
        guard let settingViewController = storyboard.instantiateViewController(withIdentifier: Self.className) as? SettingViewController else { return }
        
        viewController.navigationController?.pushViewController(
            settingViewController, animated: true
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configureView() {
        self.confirmButton.layer.cornerRadius = 10
        self.confirmButton.layer.masksToBounds = false
        self.confirmButton.clipsToBounds = true
        
        let cleanGesture = UITapGestureRecognizer(
            target: self, action: #selector(cleanTap)
        )
        self.cleanView.addGestureRecognizer(cleanGesture)
        
        let washGesture = UITapGestureRecognizer(
            target: self, action: #selector(washTap)
        )
        self.washView.addGestureRecognizer(washGesture)
        
        let kitchenGesture = UITapGestureRecognizer(
            target: self, action: #selector(kitchenTap)
        )
        self.kitchenView.addGestureRecognizer(kitchenGesture)
        
        let friendGesture = UITapGestureRecognizer(
            target: self, action: #selector(friendTap)
        )
        self.friendView.addGestureRecognizer(friendGesture)
        
        let paymentGesture = UITapGestureRecognizer(
            target: self, action: #selector(paymentTap)
        )
        self.paymentView.addGestureRecognizer(paymentGesture)
    }
    
    @objc private func cleanTap() {
        if clean {
            cleanView.alpha = 0.3
        } else {
            cleanView.alpha = 1
        }
        
        clean = !clean
    }
    
    @objc private func washTap() {
        if wash{
            washView.alpha = 0.3
        } else {
            washView.alpha = 1
        }
        
        wash = !wash
    }
    
    @objc private func kitchenTap() {
        if kitchen {
            kitchenView.alpha = 0.3
        } else {
            kitchenView.alpha = 1
        }
        
        kitchen = !kitchen
    }
    
    @objc private func friendTap() {
        if friend {
            friendView.alpha = 0.3
        } else {
            friendView.alpha = 1
        }
        
        friend = !friend
        
    }
    
    @objc private func paymentTap() {
        if payment {
            paymentView.alpha = 0.3
        } else {
            paymentView.alpha = 1
        }
        
        payment = !payment
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        self.navigationController?.pushViewController(RootTabBarController(), animated: true)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        self.navigationController?.pushViewController(RootTabBarController(), animated: true)
    }
}
