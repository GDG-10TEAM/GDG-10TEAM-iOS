//
//  TopTabBarView.swift
//  GDGiOS
//
//  Created by 김수빈 on 2022/06/25.
//

import UIKit
import SnapKit
import Then

class TopTabBarView: UIView {
    
    let colorArr = [
        UIColor.mainNavy,
        UIColor.mainGray,
        UIColor.mainRed,
        UIColor.mainYellow,
        UIColor.mainGreen
    ]
    
    let labelArr = [
        "청소",
        "빨래",
        "주방",
        "화장실",
        "공과금"
    ]
    
    let btnStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    required init(selectedIndex: Int) {
        super.init(frame: .zero)
        
        self.addSubview(btnStackView)
        btnStackView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
            $0.height.equalTo(42)
        }

        for i in 0..<colorArr.count {
            let btnView = UIButton().then {
                $0.tag = i
            }
            let lineView = UIView().then {
                $0.backgroundColor = colorArr[i]
            }
            
            let label = UILabel().then {
                $0.text = labelArr[i]
                $0.font = .systemFont(ofSize: 14, weight: .bold)
                $0.textColor = .darkGrayBlack
                $0.textAlignment = .center
            }
            
            btnStackView.addArrangedSubview(btnView)
            btnView.snp.makeConstraints {
                $0.height.equalToSuperview()
            }
            btnView.addSubview(lineView)
            btnView.addSubview(label)
            
            lineView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.height.equalTo(3)
                $0.width.equalTo(25)
                $0.bottom.equalToSuperview()
            }
            if selectedIndex == i{
                lineView.isHidden = false
            }else{
                lineView.isHidden = true
            }
            label.snp.makeConstraints {
                $0.centerY.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(13)
            }
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func changeView(selectedIndex: Int){
        for subview in btnStackView.arrangedSubviews {
            let myViews = (subview as! UIButton).subviews.filter{$0 is UIView}
            myViews.forEach { $0.isHidden = true}
        }
    }
}

