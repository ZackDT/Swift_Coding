//
//  PhoneCodeButton.swift
//  DNTouTiao
//
//  Created by 刘耀 on 2017/6/30.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

open class PhoneCodeButton: UIButton {

    // MARK:暴露的方法
    // MARK: Init
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        defaultInit()
    }
    
    public init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: w, height: h))
        defaultInit()
    }
    
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        defaultInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    private func defaultInit() {
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        isEnabled = true
        addSubview(lineView)
    }
    
    open override var isEnabled: Bool {
        didSet {
            let foreColor = isEnabled ? kColorBrandGreen: kColorCCC
            setTitleColor(foreColor, for: .normal)
            if isEnabled {
                setTitle("发送验证码", for: .normal)
            }else if(titleLabel?.text == "发送验证码") {
                setTitle("正在发送...", for: .normal)
            }
        }
    }
    
    // MARK: - 懒加载
    fileprivate lazy var lineView: UIView = {
       let line = UIView(x: -10, y: 5, w: 0.5, h: self.height - 10)
        line.backgroundColor = UIColor(hex: 0xD8D8D8)
        return line
    }()
    fileprivate var timer: Timer?
    fileprivate var duration: TimeInterval = 60
    
    @objc fileprivate func redrawTimer(timer: Timer) {
        duration = duration - 1
        if duration > 0 {
            titleLabel?.text = "\(duration) 秒"//防止 button_title 闪烁
            setTitle("\(duration) 秒", for: .normal)
        }else {
            invalidateTimer()
        }
    }
}

// MARK: - 暴露出去的方法
extension PhoneCodeButton {
    func startUpTimer() {
        if isEnabled {
            isEnabled = false
        }
        setTitle("\(duration) 秒", for: .normal)
        timer = Timer(timeInterval: 1, target: self, selector: #selector(redrawTimer(timer:)), userInfo: nil, repeats: true)
    }
    
    func invalidateTimer() {
        if !isEnabled {
            isEnabled = true
        }
        timer?.invalidate()
        timer = nil
    }
}
