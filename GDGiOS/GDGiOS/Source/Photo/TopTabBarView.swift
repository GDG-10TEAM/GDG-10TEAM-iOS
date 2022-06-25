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
    let screenWidth = UIScreen.main.bounds.size.width
    
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
    
    let lineSuperView1 = UIView()
    let lineSuperView2 = UIView()
    let lineSuperView3 = UIView()
    let lineSuperView4 = UIView()
    let lineSuperView5 = UIView()
    
    let lineView1 = UIView().then{
        $0.backgroundColor = UIColor.mainNavy
    }
    let lineView2 = UIView().then{
        $0.backgroundColor =  UIColor.mainRed
    }
    let lineView3 = UIView().then{
        $0.backgroundColor =  UIColor.mainRed
    }
    let lineView4 = UIView().then{
        $0.backgroundColor =  UIColor.mainYellow
    }
    let lineView5 = UIView().then{
        $0.backgroundColor =  UIColor.mainGreen
    }
    
    required init(selectedIndex: Int) {
        super.init(frame: .zero)
        self.addSubview(lineSuperView1)
        self.addSubview(lineSuperView2)
        self.addSubview(lineSuperView3)
        self.addSubview(lineSuperView4)
        self.addSubview(lineSuperView5)
        
        lineSuperView1.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.leading.equalToSuperview()
            $0.width.equalTo(screenWidth/5)
        }
        
        lineSuperView2.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(lineSuperView1.snp.trailing)
            $0.width.equalTo(screenWidth/5)
        }
        
        lineSuperView3.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(lineSuperView2.snp.trailing)
            $0.width.equalTo(screenWidth/5)
        }
        
        lineSuperView4.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(lineSuperView3.snp.trailing)
            $0.width.equalTo(screenWidth/5)
        }
        
        lineSuperView5.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(lineSuperView4.snp.trailing)
            $0.width.equalTo(screenWidth/5)
        }
        
        lineSuperView1.addSubview(lineView1)
        lineSuperView2.addSubview(lineView2)
        lineSuperView3.addSubview(lineView3)
        lineSuperView4.addSubview(lineView4)
        lineSuperView5.addSubview(lineView5)
        
        lineView1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(25)
        }
        
        lineView2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(25)
        }
        
        lineView3.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(25)
        }
        
        lineView4.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(25)
        }
        
        lineView5.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(25)
        }
        
        self.addSubview(btnStackView)
        btnStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(39)
        }

        for i in 0..<colorArr.count {
            let btnView = UIButton().then {
                $0.tag = i
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
            btnView.addSubview(label)

            setLineView(selectedIndex: selectedIndex)
            label.snp.makeConstraints {
                $0.centerY.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(13)
            }
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setLineView(selectedIndex: Int){
        lineView1.isHidden = true
        lineView2.isHidden = true
        lineView3.isHidden = true
        lineView4.isHidden = true
        lineView5.isHidden = true
        switch selectedIndex {
            case 0: lineView1.isHidden = false
            case 1: lineView2.isHidden = false
            case 2: lineView3.isHidden = false
            case 3: lineView4.isHidden = false
            case 4: lineView5.isHidden = false
            default: break

        }
    }
    
    func changeView(selectedIndex: Int){
        setLineView(selectedIndex: selectedIndex)
    }
}

