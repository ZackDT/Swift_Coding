
//
//  LoginHeaderAndFooterView.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit


/// 加载头部视图
class RegisterHeaderView: UIView {
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.15 * kScreen_Height))
        setupUI()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0.15 * kScreen_Height))
        setupUI()
    }
    
    fileprivate func setupUI() {
        let label = UILabel(title: "加入Coding，体验云端开发之美！", size: CGRect(x: 0, y: 0, width: kScreenW, height: 18), fontSize: 18, color: kColor222, alignment: .center)
        label.center = self.center
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// 加载尾部视图
class RegisterFooterView: UIView {
    
    fileprivate lazy var footerBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("注册", for: .normal)
        btn.frame = CGRect(x: kLoginPaddingLeftWidth, y: 20, width: kScreen_Width-kLoginPaddingLeftWidth*2, height: 45)
        btn.addTarget(self, action: #selector(sendRegister), for: .touchUpInside)
        btn.type(.success)
        return btn
    }()
    
    fileprivate lazy var label: YYLabel = {
        let label = YYLabel()
        let message = "注册 Coding 账号表示您已同意 《Coding 服务条款》"
        let registerN : NSAttributedString = NSAttributedString(string: message, attributes: [NSForegroundColorAttributeName : kColor999, NSFontAttributeName : UIFont.boldSystemFont(ofSize: 12)])
        let attributedStrM = NSMutableAttributedString(attributedString: registerN)
        attributedStrM.yy_setTextHighlight((message as NSString).range(of: "《Coding 服务条款》"), color: kColorBrandGreen, backgroundColor: UIColor.clear, userInfo: nil, tapAction: { (view, attr, range, crect) in
            QL1("《Coding 服务条款》")
        }, longPressAction: nil)
        label.attributedText = attributedStrM
        return label
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 150))
        
        addSubview(footerBtn)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(footerBtn.snp.bottom).offset(12)
            make.right.equalTo(footerBtn.snp.right)
            make.height.equalTo(14)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func sendRegister() {
        QL1("注册")
    }

}
