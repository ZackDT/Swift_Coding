//
//  LoginViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import RazzleDazzle


private let buttonWidth: CGFloat = kScreenW * 0.4
private let buttonHeight = kScaleDesign(38)

class IntroductionViewController: AnimatedPagingScrollViewController {

    // MARK: 定义属性
    lazy var iconsDict:[String: Any] = [
        "0_image" : "intro_icon_6",
        "1_image" : "intro_icon_0",
        "2_image" : "intro_icon_1",
        "3_image" : "intro_icon_2",
        "4_image" : "intro_icon_3",
        "5_image" : "intro_icon_4",
        "6_image" : "intro_icon_5"
    ]
    lazy var tipsDict:[String: Any] = [
        "0_image" : "",
        "1_image" : "intro_tip_0",
        "2_image" : "intro_tip_1",
        "3_image" : "intro_tip_2",
        "4_image" : "intro_tip_3",
        "5_image" : "intro_tip_4",
        "6_image" : "intro_tip_5"
    ]
    lazy var registerBtn: UIButton = {
       let btn = UIButton(title: "注册", fontSize: 20, color: .white, imageName: nil, backColor: kColorBrandGreen)
        btn.corner(radius: buttonHeight * 0.5)
        btn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        return btn
    }()
    lazy var loginBtn: UIButton = {
        let btn = UIButton(title: "登录", fontSize: 20, color: kColorBrandGreen, imageName: nil, backColor: .clear)
        btn.corner(radius: buttonHeight * 0.5)
        btn.border(1, kColorBrandGreen)
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var pageConrol: SMPageControl = {
        let pageControl = SMPageControl()
        pageControl.numberOfPages = 7
        pageControl.isUserInteractionEnabled = false
        let factor = kScaleDesign(1)
        pageControl.pageIndicatorImage = UIImage(named: "intro_dot_unselected")
        pageControl.currentPageIndicatorImage = UIImage(named: "intro_dot_selected")
        pageControl.sizeToFit()
        pageControl.currentPage = 0;
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: 0xf1f1f1)
        
        configureViews() //添加视图
        configureAnimations()   // 添加动画
    }
    
    override func numberOfPages() -> Int {
        return 7
    }
}

// MARK: - UI设置
extension IntroductionViewController {
    fileprivate func configureViews() {
        configureButtonAndPageController()
        
        for i in 0..<self.numberOfPages() {
            // 自己定义的,直接强制解包
            let iconName = iconsDict["\(i)_image"] as! String
            let tipIconName = tipsDict["\(i)_image"] as! String
            let iconImg = UIImage(named: iconName)
            let tipImg = UIImage(named: tipIconName)
            let iconView = UIImageView(image: iconImg)
            let tipView = UIImageView(image: tipImg)
            
            contentView.addSubview(iconView)
            contentView.addSubview(tipView)
            
            iconsDict.updateValue(iconView, forKey: "\(i)_view")
            tipsDict.updateValue(tipView, forKey: "\(i)_view")
        }
    }
    fileprivate func configureAnimations() {
        for i in 0..<self.numberOfPages() {
            // 自己定义的,直接强制解包 不判断了
            let iconView = iconsDict["\(i)_view"] as! UIImageView
            let tipView = tipsDict["\(i)_view"] as! UIImageView
            
            let index = CGFloat(i)
            if i == 0 {
                keepView(iconView, onPages: [index+1,index], atTimes: [index-1,index])
                iconView.snp.makeConstraints({ (make) in
                    make.top.equalTo(kScreen_Height/7)
                })
            }else {
                keepView(iconView, onPage: index)
                iconView.snp.makeConstraints({ (make) in
                    make.centerY.equalTo(self.view.snp.centerY).offset(-kScreen_Height/6)
                })
            }
            let iconAnimation = AlphaAnimation(view: iconView)
            iconAnimation.addKeyframe(index - 0.5, value: 0)
            iconAnimation.addKeyframe(index, value: 1)
            iconAnimation.addKeyframe(index + 0.5, value: 0)
            animator.addAnimation(iconAnimation)
            
            keepView(tipView, onPages: [index + 1, index, index - 1], atTimes: [index - 1, index ,index + 1])
            let tipAnimation = AlphaAnimation(view: tipView)
            tipAnimation.addKeyframe(index - 0.5, value: 0)
            tipAnimation.addKeyframe(index, value: 1)
            tipAnimation.addKeyframe(index + 0.5, value: 0)
            animator.addAnimation(tipAnimation)
            tipView.snp.makeConstraints({ (make) in
                make.top.equalTo(iconView.snp.bottom).offset(kScaleDesign(45));
            })
        }
    }
    
    private func configureButtonAndPageController() {
        // 注册登录按钮
        let paddingToCenter = kScaleDesign(10)
        let paddingToBottom = kScaleDesign(20)
        
        view.addSubview(registerBtn)
        view.addSubview(loginBtn)
        
        registerBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: buttonWidth, height: buttonHeight))
            make.right.equalTo(self.view.snp.centerX).offset(-paddingToCenter)
            make.bottom.equalTo(-paddingToBottom)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.size.equalTo(registerBtn.snp.size)
            make.left.equalTo(self.view.snp.centerX).offset(paddingToCenter)
            make.bottom.equalTo(registerBtn.snp.bottom)
        }
        
        // PageController
        view.addSubview(pageConrol)
        pageConrol.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: kScreen_Width, height: kScaleDesign(20)))
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.registerBtn.snp.top).offset(-kScaleDesign(20))
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let nearestpage = floor(self.pageOffset + 0.5)
        pageConrol.currentPage = Int(nearestpage)
    }
 
}


// MARK: - 点击事件
extension IntroductionViewController {
    @objc fileprivate func registerBtnClick() {
        let anv = BaseNavigationController(rootViewController: RegisterViewController())
        present(anv, animated: true, completion: nil)
    }
    
    @objc fileprivate func loginBtnClick() {
        let anv = BaseNavigationController(rootViewController: LoginViewController())
        present(anv, animated: true, completion: nil)
    }
}
