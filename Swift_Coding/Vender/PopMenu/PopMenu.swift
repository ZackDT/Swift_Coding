//
//  PopMenu.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import Spring

enum PopMenuAnimationType: Int {
    case sina = 0  /** 从下部入 下部出*/
    case netEase  /** 从右侧入 左侧出*/
    
}

private let MenuButtonHeight: Float = 110
private let MenuButtonHorizontalMargin: Float = 10.0
private let MenuButtonVerticalPadding: Float = 10.0
private let kMenuButtonBaseTag:Int = 100

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
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: { 
            self.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    /// 将菜单显示到某个视图上
    ///
    /// - Parameter atView: 要显示的父视图
    func show(_ containerView:UIView) {
        self.startPoint = CGPoint(x: 0, y: self.h)
        self.endPoint = self.startPoint
        if(self.isShowed){
            return
        }
        self.clipsToBounds = true
        containerView.addSubview(self)
        self.blurView.show(atView: self)
    }
    
    func show(atView containerView: UIView, startPoint: CGPoint, endPoint: CGPoint) {
       
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
            var menuBtn = self.viewWithTag(kMenuButtonBaseTag + i) as? SpringView
            let toRect:CGRect = getFrameOfItem(AtIndex: i, itemWidth: itemWidth)
            let fromRect = toRect
            
            if menuBtn == nil {
                menuBtn = MenuButton(frame: fromRect, item: item)
                menuBtn!.tag = kMenuButtonBaseTag + i
                self.addSubview(menuBtn!)
            }else {
                menuBtn?.frame = fromRect
            }
            
//            let delaySec = Double(items.count - i) * (0.1 / 5.0)
//            animation(to: toRect, from: fromRect, atView: menuBtn!, beginTime: delaySec)
            
        }

    }
    
    
    /// 隐藏菜单按钮
    fileprivate func hideButtons() {
        
    }
    
    func getFrameOfItem(AtIndex index:Int, itemWidth:Float) -> CGRect {

        let insetY:Float = Float(kScreenH) * 0.12
        // 计算行位置
        let originX:Float = Float(index % self.perRowItemCount) * (itemWidth + MenuButtonHorizontalMargin) + MenuButtonHorizontalMargin
        // 计算列位置
        let originY:Float = Float(index / self.perRowItemCount) * (MenuButtonHeight + MenuButtonVerticalPadding) + MenuButtonVerticalPadding
        
        let itemFrame:CGRect = CGRect(x: CGFloat(originX), y: CGFloat(insetY + originY), width: CGFloat(itemWidth), height: CGFloat(MenuButtonHeight))
        return itemFrame;
    }
    
    private func animation(to: CGRect, from: CGRect, atView: SpringView, beginTime: Double) {
        atView.delay = CGFloat(beginTime)
        atView.y = frame.y
        atView.animation = "slideDown"
        atView.curve = "easeInOut"
        atView.animate()
    }
}
