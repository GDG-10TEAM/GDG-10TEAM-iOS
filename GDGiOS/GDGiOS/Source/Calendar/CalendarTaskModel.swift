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
}
