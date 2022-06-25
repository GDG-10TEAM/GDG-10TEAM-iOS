//
//  CalendarTaskModel.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import UIKit

enum CalendarTaskModel {
    case clean, wash, kitchen, friend, payment
    
    var color: UIColor {
        switch self {
        case .clean:
            return UIColor.mainNavy
        case .wash:
            return UIColor.mainGray
        case .kitchen:
            return UIColor.mainRed
        case .friend:
            return UIColor.mainYellow
        case .payment:
            return UIColor.mainGreen
        }
    }
    
    var image: UIImage? {
        switch self {
        case .clean:
            return UIImage(named: "cha_01_01")
        case .wash:
            return UIImage(named: "cha_02_01")
        case .kitchen:
            return UIImage(named: "cha_03_01")
        case .friend:
            return UIImage(named: "cha_04_01")
        case .payment:
            return UIImage(named: "cha_05_01")
        }
    }
}
