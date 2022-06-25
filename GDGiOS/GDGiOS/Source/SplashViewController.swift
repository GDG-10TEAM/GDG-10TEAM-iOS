//
//  SplashViewController.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/26.
//

import UIKit
import Gifu
import SnapKit
import Then

class SplashViewController: UIViewController {

   override func viewDidLoad() {
        super.viewDidLoad()
       let imageView = GIFImageView()
       imageView.animate(withGIFNamed: "img-splash")

       self.view.addSubview(imageView)
       imageView.snp.makeConstraints {
           $0.leading.trailing.top.bottom.equalToSuperview()
       }
   }

}
