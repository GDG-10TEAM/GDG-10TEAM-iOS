//
//  BaseViewController.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/25.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    class var className : String {
        return String(describing: self)
    }
}

