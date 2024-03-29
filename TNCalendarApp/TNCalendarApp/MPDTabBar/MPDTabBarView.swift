//
//  MPDTabBarView.swift
//  MPD
//
//  Created by 涂育旺 on 2017/6/12.
//  Copyright © 2017年 Qianhai Jiutong. All rights reserved.
//

import UIKit
import Foundation

protocol MPDTabBarViewViewDelegate {
    func MPDTabBar(tabBar: MPDTabBarButton, index: Int)
}

class MPDTabBarView: UIView {

    var delegate: MPDTabBarViewViewDelegate?
    
    private var selectedBtn: UIButton?
    private var selectedIndex = 0
    private let images = ["Icon-Calendar", "Icon-Add", "Icon-Overview"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        selectedIndex = defaultTabbarSelected
        
        for i in 0..<images.count {
            let btn = MPDTabBarButton(type: .custom)
            if i == defaultTabbarSelected {
                btn.extensionScale = 50
                selectedBtn = btn
                selectedBtn!.isSelected = !self.selectedBtn!.isSelected
            }
            
            btn.frame = CGRect(x: CGFloat(i)*SCREEN_WIDTH/3, y: 0, width: SCREEN_WIDTH/3, height: TABBAR_HEIGHT)
            btn.tag = 2017 + i
            btn.setImage(ImageName(images[i]), for: .normal)
            btn.addTarget(self, action: #selector(MPDTabBarView.barBarButtonClick(_:)), for: .touchUpInside)
            
            addSubview(btn)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func barBarButtonClick(_ button:MPDTabBarButton) {
        
        let i = button.tag - 2017
        guard self.delegate != nil else { return }
        self.delegate?.MPDTabBar(tabBar: button, index: i)
        
        guard i != 1 else { return }
        MPDWaterRippleView.showInView(view: self, center: button.center)
        setSelectedItem(index: i)
        
    }
    
    func setSelectedItem(index: Int) {
        let currentButton = viewWithTag(2017+index) as! MPDTabBarButton
        
        if  self.selectedBtn != currentButton {
            self.selectedBtn!.isSelected = false
        }
        self.selectedBtn?.setImage(ImageName(self.images[selectedIndex]), for: .normal)
        currentButton.setImage(ImageName("\(images[index])-hight"), for: .normal)
        self.selectedBtn = currentButton
        self.selectedIndex = index
        self.selectedBtn!.isSelected = true
    }
}
