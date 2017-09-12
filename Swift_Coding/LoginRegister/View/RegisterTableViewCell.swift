
//
//  LoginHeaderAndFooterView.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

enum RegisterCellType: String {
    case text       //只有text
    case captcha    // 验证码
    case password   // 密码
    case phoneCode  // 验证码
    case phone      // 电话
}

class RegisterTableViewCell: UITableViewCell {
    
    // MARK: - 属性
    var type: RegisterCellType!
    
    // MARK: -  闭包
    var textValueClosure:((String) -> Void)?
    var editDidBeginClosure:((String) -> Void)?
    var editDidEndClosure:((String) -> Void)?
    var phoneCodeBtnClckedClosure:((UIButton) -> Void)?
    var countryCodeBtnClickedClosure:(() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        type = RegisterCellType.init(rawValue: reuseIdentifier!)
        
        selectionStyle = .none
        setupUI(type: type!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    // MARK: - 属性设置
    
    var placeholderColor: UIColor = kColor999
    /// 输入框
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(edittDidBegin(id:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editDidEnd(id:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textValueChanged(id:)), for: .editingChanged)
        return textField
    }()
    
    /// 验证码视图
    lazy var captchaView: UIImageView = {
       let imgV = UIImageView(x: kScreen_Width - 60 - kLoginPaddingLeftWidth, y: (44-25)/2, w: 60, h: 25)
        imgV.addTapGesture(target: self, action: #selector(refreshCaptchaImage))
        return imgV
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
       let act = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        act.hidesWhenStopped = true
        return act
    }()
    
    // Password
    lazy var passwordBtn: UIButton = {
        let btn = UIButton(x: kScreen_Width - 44 - kLoginPaddingLeftWidth, y: 0, w: 44, h: 44, target: self, action: #selector(passwordBtnClick(sender:)))
        btn.setImage(UIImage(named: "password_unlook"), for: .normal)
        return btn
    }()
    
    // phoneCode
    lazy var verifyCodeBtn: PhoneCodeButton = {
        let btn = PhoneCodeButton(x: kScreen_Width - 80 - kLoginPaddingLeftWidth, y: (44-25) * 0.5, w: 80, h: 25, target: self, action: #selector(phoneCodeBtnClick(sender:)))
        
        return btn
    }()
    
    // 国家 默认写中国
    lazy var countryCodeL: UILabel = {
       let label = UILabel(title: "+86", fontSize: 17, color: kColorBrandGreen)
        return label
    }()
    
    fileprivate lazy var lineView: UIView = {
       let line = UIView()
        line.backgroundColor = kColorDDD
        return line
    }()
    
}


// MARK: - 设置UI
extension RegisterTableViewCell {
    fileprivate func setupUI(type:RegisterCellType) {
        
        setOnlyText()
        
        switch type {
        case .text:
            QL1("text")
        case .captcha:
            setCaptchaText()
        case .password:
            setPasswordText()
        case .phoneCode:
            setPhoneCodeText()
        case .phone:
            setPhoneText()
        }
        
    }
    
    private func setOnlyText() {
        contentView.addSubview(textField)
        contentView.addSubview(lineView)
        
        textField.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalTo(kLoginPaddingLeftWidth)
            make.right.equalTo(-kLoginPaddingLeftWidth)
            make.centerY.equalTo(self.contentView)
        }
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(kLoginPaddingLeftWidth)
            make.right.equalTo(-kLoginPaddingLeftWidth)
            make.bottom.equalTo(0)
        }
    }
    
    private func setCaptchaText() {
        contentView.addSubview(captchaView)
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalTo(self.captchaView)
        }
    }
    
    private func setPasswordText() {
        textField.isSecureTextEntry = true
        contentView.addSubview(passwordBtn)
        textField.snp.updateConstraints { (make) in
            make.right.equalTo(-(passwordBtn.width + kLoginPaddingLeftWidth + 8))
        }
    }
    
    private func setPhoneCodeText() {
        textField.keyboardType = .numberPad
        contentView.addSubview(verifyCodeBtn)
        textField.snp.updateConstraints { (make) in
            make.right.equalTo(-(verifyCodeBtn.width + kLoginPaddingLeftWidth + 8))
        }
    }
    
    private func setPhoneText() {
        textField.keyboardType = .numberPad
        contentView.addSubview(countryCodeL)
        countryCodeL.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(kPaddingLeftWidth)
            make.centerY.equalTo(self.contentView)
        }
        
        let line = UIView()
        line.backgroundColor = kColorCCC
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(countryCodeL.snp.right).offset(8)
            make.centerY.equalTo(self.countryCodeL)
            make.width.equalTo(0.5)
            make.height.equalTo(15.0)
        }
        
        let bgBtn = UIButton()
        contentView.addSubview(bgBtn)
        bgBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(contentView)
            make.right.equalTo(line)
        }
        bgBtn.addTarget(self, action: #selector(countryCodeBtnClicked(sender:)), for: .touchUpInside)
        
        textField.snp.remakeConstraints { (make) in
            make.height.equalTo(20)
            make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth)
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(line.snp.right).offset(8.0)
        }
    }
    
}


// MARK: - 点击事件
extension RegisterTableViewCell {
    @objc fileprivate func refreshCaptchaImage() {
        
    }
    
    @objc fileprivate func passwordBtnClick(sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        let image = textField.isSecureTextEntry ? UIImage(named: "password_unlook") : UIImage(named: "password_look")
        passwordBtn.setImage(image, for: .normal)
    }
    
    @objc fileprivate func phoneCodeBtnClick(sender: UIButton) {
        
    }
    
    @objc fileprivate func countryCodeBtnClicked(sender: UIButton) {
        
    }
}

// MARK: - TextField
extension RegisterTableViewCell {
    @objc fileprivate func edittDidBegin(id: UITextField) {
        
    }
    @objc fileprivate func editDidEnd(id: UITextField) {
        
    }
    @objc fileprivate func textValueChanged(id: UITextField) {
        
    }
}


// MARK: - 暴露出去的方法
extension RegisterTableViewCell {
    func setText(placeholder: String, value: String?) {
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        textField.text = value
    }
}
