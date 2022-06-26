//
//  MainDTO.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import UIKit

struct MainDTO: Codable {
    let task_seq: Int
    let end_date: String
    let name: String
    let category_name: Category
}

// 청소, 세탁(빨래), 키친(주방), 반려, 납부(공과금)
enum Category: String, Codable {
    case cleaning = "청소"
    case washing = "세탁"
    case friend = "반려"
    case payment = "납부" // 공과금
    case kitchen = "키친"
    
    var color: UIColor {
        switch self {
        case .cleaning:
            return UIColor.mainNavy
        case .washing:
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
        case .cleaning:
            return UIImage(named: "cha_01_01")
        case .washing:
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
