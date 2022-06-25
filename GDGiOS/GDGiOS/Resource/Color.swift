//
//  Color.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/25.
//
import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    class var mainNavy: UIColor { UIColor(hex: 0x4B567D)}
    class var mainGray: UIColor { UIColor(hex: 0xEEEEFF)}
    class var mainRed: UIColor { UIColor(hex: 0xFF6060)}
    class var mainYellow: UIColor { UIColor(hex: 0xFCD930)}
    class var mainGreen: UIColor { UIColor(hex: 0x2AD32E)}
    class var darkGrayBlack: UIColor { UIColor(hex: 0x585858)}
}
