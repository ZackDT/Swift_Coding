//
//  UIButton+Extension.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit


// MARK: - 初始化方法
extension UIButton {
    
    /// 返回按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体大小
    ///   - color: 颜色
    ///   - imageName: 图像名称
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = UIColor.clear) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        if let imageName = imageName {
            setImage(UIImage(named:imageName), for: .normal)
        }
        backgroundColor = backColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
    }
    
    
}


// MARK: - 设置方法
extension UIButton {
    
    /// 设置背景色
    ///
    /// - Parameters:
    ///   - color: color description
    ///   - forState: forState description
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState? = .normal) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState!)
    }
    
    /// 设置字体
    ///
    /// - Parameter font: font description
    public func font(_ font: CGFloat) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: font)
    }
    
    public func rightImg(_ titleStr: String, _ maxWidth: CGFloat? = kScreenW - 30, imageW: CGFloat, btnH: CGFloat, imageName: String) {
        let titleW = titleStr.size(withFont: self.titleLabel!.font, maxWidth: maxWidth!).width
        let btnW = titleW + imageW
        self.frame = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW, 0, imageW)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW, 0, -titleW)
        self.setTitle(titleStr, for: .normal)
        self.setImage(UIImage(named: imageName), for: .normal)
    }
    
    
}
