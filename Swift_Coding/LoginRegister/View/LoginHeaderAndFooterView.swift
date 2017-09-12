
//
//  LoginHeaderAndFooterView.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import SnapKit

class LoginHeaderView: UIView {
    
    // MARK: - 懒加载
    lazy var userIcon: UIImageView = {
        let hw: CGFloat = kScreenW >= 375.0 ? 100 : 75
        let imgV = UIImageView(x: 0, y: 0, w: hw, h: hw, imageName: "icon_user_monkey")
        imgV.corner(radius: hw * 0.5)
        imgV.border(2, .white)
        return imgV
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreen_Height/3))
        setupUI()
    }
    
    init() {
        
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreen_Height/3))
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(userIcon)
        userIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(30)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoginFooterView: UIView {
    
    
    // MARK: - 属性设置
    lazy var loginBtn: UIButton = {
        let btn = UIButton(x: kLoginPaddingLeftWidth, y: 20, w: kScreen_Width-kLoginPaddingLeftWidth*2, h: 45, target: self, action: #selector(loginBtnClick(sender:)))
        btn.type(.success)
        btn.setTitle("登录", for: .normal)
        return btn
    }()
    lazy var rewriteBtn: UIButton = {
        let btn = UIButton(x: 0, y: 0, w: 100, h: 30, target: self, action: #selector(rewriteBtnClick(sender:)))
        btn.setTitle("找回密码", for: .normal)
        btn.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .normal)
        btn.setTitleColor(UIColor(white: 0.5, alpha: 0.5), for: .highlighted)
        btn.font(14)
        return btn
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 150))
        setupUI()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: kScreen_Height - 55, width: kScreenW, height: 150))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.backgroundColor = .clear
        addSubview(loginBtn)
        addSubview(rewriteBtn)
        rewriteBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
        }
    }
    
    // MARK: - 方法
    @objc func loginBtnClick(sender: UIButton) {
        
    }
    @objc func rewriteBtnClick(sender: UIButton) {
        
    }
    
    
}
