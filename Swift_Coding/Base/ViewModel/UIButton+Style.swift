//
//  UIButton+Style.swift
//  DNTouTiao
//
//  Created by 刘耀 on 2017/6/28.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

enum ButtonType {
    case bootstrap
    case primary
    case success
    case info
    case warning
    case danger
}

extension UIButton {
    func type(_ type: ButtonType) {

        setbtnType(type: type)
    }
    
    private func bootsTrap() {
        self.corner(radius: self.height * 0.5)
        self.adjustsImageWhenHighlighted = false
        self.setTitleColor(.white, for: .normal)
        self.titleLabel!.font = UIFont(name: "FontAwesome", size: self.titleLabel!.font.pointSize)
    }
    
    private func setbtnType(type: ButtonType) {
        switch type {
        case .bootstrap:
            bootsTrap()
        case .primary:
            bootsTrap()
            backgroundColor = kColorBrandGreen
            border(1, kColorBrandGreen)
            setBackgroundImage(imageFrom(color: UIColor(hex: "0x28a464")!), for: .highlighted)
        case .success:
            bootsTrap()
            border(1, .clear)
            setBackgroundImage(imageFrom(color: kColorBrandGreen), for: .normal)
            setBackgroundImage(imageFrom(color:  UIColor(hex: 0x3BBD79,alp:0.5)), for: .disabled)
            setBackgroundImage(imageFrom(color: UIColor(hex: 0x3BBD79,alp:0.5)), for: .highlighted)
            setTitleColor(.white, for: .normal)
            setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .disabled)
            setTitleColor(.white, for: .highlighted)
        case .info:
            bootsTrap()
            border(1, .clear)
            setBackgroundImage(imageFrom(color: UIColor(hex: "0x4E90BF")!), for: .normal)
            setBackgroundImage(imageFrom(color: UIColor(hex: "0x4E90BF", alpha: 0.5)!), for: .disabled)
            setBackgroundImage(imageFrom(color: UIColor(hex: "0x4E90BF", alpha: 0.5)!), for: .highlighted)
            setTitleColor(.white, for: .normal)
            setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .disabled)
            setTitleColor(.white, for: .highlighted)
        case .warning:
            bootsTrap()
            backgroundColor = UIColor(hex: "0xff5847")!
            border(1, UIColor(hex: "0xff5847")!)
            setBackgroundImage(imageFrom(color: UIColor(hex: "0xef4837", alpha: 0.5)!), for: .highlighted)
        case .danger:
            // danger
            bootsTrap()
            backgroundColor = UIColor(r: 217, g: 83, b: 58, alpha: 79)
            border(1, UIColor(r: 212, g: 63, b: 58, alpha: 1))
            setBackgroundImage(imageFrom(color: UIColor(r: 210, g: 48, b: 51, alpha: 1)), for: .highlighted)
        }
    }
}
