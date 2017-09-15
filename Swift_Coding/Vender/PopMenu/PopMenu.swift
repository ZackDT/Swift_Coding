//
//  PopMenu.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import pop

enum PopMenuAnimationType: Int {
    case sina = 0  /** 从下部入 下部出*/
    case netEase  /** 从右侧入 左侧出*/
    
}

private let MenuButtonHeight: Float = 110
private let MenuButtonHorizontalMargin: Float = 10.0
private let MenuButtonVerticalPadding: Float = 10.0
private let kMenuButtonBaseTag:Int = 100
private let MenuItemAnimationInterval:Double = 0.02
/// 菜单栏
class PopMenu: UIView {
    // MARK: - 暴露的属性
    var aniType: PopMenuAnimationType = .sina
    var selectedItemBlock: ((_ item: MenuItem) -> ())?
    var items: Array = [MenuItem]()
    var perRowItemCount: Int = 3
    fileprivate(set) var isShowed = false
    
    // MARK: - 内部属性
    fileprivate var startPoint:CGPoint!
    fileprivate var endPoint:CGPoint!
    fileprivate lazy var blurView: BlurView = {
        let blur = BlurView(frame: self.bounds)
        blur.hasTapGustureEnable = true
        blur.delegate = self
        return blur
    }()
    
    // MARK: - 暴露的方法
    /// 容器dismiss
    func dismiss() {
        blurView.dismiss()
    }
    
    /// 将菜单显示到某个视图上
    ///
    /// - Parameter atView: 要显示的父视图
    func show(_ containerView:UIView) {
        if(isShowed){
            return
        }
        clipsToBounds = true
        containerView.addSubview(self)
        blurView.show(atView: self)
    }
    
    init(frame: CGRect, items: Array<MenuItem>) {
        super.init(frame: frame)
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    

}

extension PopMenu: BlurViewProtocol {
    func willShowBlurView() {
        self.isShowed = true
        self.showButtons()
    }
    
    func willDismissBlurView() {
        hideButtons()
    }
    
    func didDismissBlurView() {
        isShowed = false
        self.removeFromSuperview()
    }
}

extension PopMenu {

    /// 添加菜单按钮
    fileprivate func showButtons() {
        let itemWidth:Float = (Float(self.bounds.size.width) - (Float(self.perRowItemCount + 1) * MenuButtonHorizontalMargin)) / Float(perRowItemCount);
        for i in 0..<self.items.count {
            let item = self.items[i]
            var menuBtn = self.viewWithTag(kMenuButtonBaseTag + i) as? MenuButton
            let toRect:CGRect = getFrameOfItem(AtIndex: i, itemWidth: itemWidth)
            var fromRect = toRect
            
            fromRect.y = -100
            if menuBtn == nil {
                menuBtn = MenuButton(frame: fromRect, item: item)
                menuBtn!.tag = kMenuButtonBaseTag + i
                menuBtn?.selectedItemCompletedBlock = { [weak self] item in
                    self?.selectedItemBlock?(item)
                }
                self.addSubview(menuBtn!)
            }else {
                menuBtn?.frame = fromRect
            }
            let delaySec = Double(items.count - i) * MenuItemAnimationInterval
            animation(to: toRect, from: fromRect, atView: menuBtn!, beginTime: delaySec)
            
        }

    }
    
    
    /// 隐藏菜单按钮
    fileprivate func hideButtons() {
        for i in 0..<items.count {
            let menuBtn = self.viewWithTag(kMenuButtonBaseTag + i) as! MenuButton
            let fromRect:CGRect = menuBtn.frame
            var toRect:CGRect = fromRect
            
            toRect.y = -100
            let delayInSeconds:Double = Double(i) * MenuItemAnimationInterval
            animation(to: toRect, from: fromRect, atView: menuBtn, beginTime: delayInSeconds)
        }
    }
    
    fileprivate func getFrameOfItem(AtIndex index:Int, itemWidth:Float) -> CGRect {

        let insetY:Float = Float(kScreenH) * 0.12
        // 计算行位置
        let originX:Float = Float(index % self.perRowItemCount) * (itemWidth + MenuButtonHorizontalMargin) + MenuButtonHorizontalMargin
        // 计算列位置
        let originY:Float = Float(index / self.perRowItemCount) * (MenuButtonHeight + MenuButtonVerticalPadding) + MenuButtonVerticalPadding
        
        let itemFrame:CGRect = CGRect(x: CGFloat(originX), y: CGFloat(insetY + originY), width: CGFloat(itemWidth), height: CGFloat(MenuButtonHeight))
        return itemFrame;
    }
    
    private func animation(to: CGRect, from: CGRect, atView: UIView, beginTime: Double) {
        let anim = POPSpringAnimation()
        anim.property = POPAnimatableProperty.property(withName: kPOPViewFrame) as! POPAnimatableProperty
        anim.removedOnCompletion = true
        anim.beginTime = beginTime + CACurrentMediaTime()
        anim.springBounciness = 6
        anim.springSpeed = 2
        anim.toValue = NSValue(cgRect: to)
        anim.fromValue = NSValue(cgRect: from)
        atView.pop_add(anim, forKey: "POPSpringAnimationKey")
        
    }
}
