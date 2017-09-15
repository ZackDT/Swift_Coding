//
//  MenuButton.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

import SnapKit

struct MenuItem {
    var title: String?
    var iconImage: String?
    var glowColor: UIColor = UIColor.gray
    var index: Int = 0
    
}

/// MenuButton 菜单视图 UIView  处理点击事件等
class MenuButton: UIView {
    
    // MARK: - 暴露的属性
    var selectedItemCompletedBlock: ((_ item:MenuItem) -> ())?
    var menuItem: MenuItem!
    var iconImageView:UIImageView!
    var titleLabel:UILabel!
    
    init(frame: CGRect, item: MenuItem) {
        super.init(frame: frame)
        self.menuItem = item
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.7
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as AnyObject // 类型转换
        let point = touch.location(in: self) //获取当前点击位置
        let prePoint = touch.previousLocation(in: self) //该方法记录了前一个坐标值
        let containframe = self.bounds
        if containframe.contains(point) && !containframe.contains(prePoint){
            self.alpha = 0.7;
        } else if !containframe.contains(point) && containframe.contains(prePoint) {
            self.alpha = 1.0
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as AnyObject // 类型转换
        let point = touch.location(in: self) //获取当前点击位置
        let containframe = self.bounds
        if containframe.contains(point) {
            selectedItemCompletedBlock?(self.menuItem)
        } else {
            self.alpha = 1.0
        }
    }
}

extension MenuButton {
    fileprivate func setupUI() {
        /// UIImageView 图片视图
        let iconImage = UIImage(named: menuItem.iconImage!)
        var imageSize = iconImage?.size ?? CGSize(width: 0, height: 0)
        if !UIDevice().iPhone6or7() && !UIDevice().iPhone6or7Plus() {
            imageSize = CGSize(width: imageSize.width * 0.9, height: imageSize.height * 0.9)
        }
        iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        iconImageView.isUserInteractionEnabled = true
        iconImageView.image = iconImage
        
        iconImageView.center = CGPoint(x: self.bounds.midX, y: iconImageView.bounds.midY);
        self.addSubview(iconImageView)
        
        /// UIlabel title
        titleLabel = UILabel(frame: CGRect(x: 0, y: self.iconImageView.frame.maxY, width: self.bounds.width, height: 35))
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.text = menuItem.title
        
        self.titleLabel.centerX = self.bounds.midX
        self.addSubview(self.titleLabel)
        
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.itemClickedMethod))
        self.addGestureRecognizer(gesture)
        
    }
    
    func itemClickedMethod(){
        self.selectedItemCompletedBlock?(self.menuItem)
    }
}
