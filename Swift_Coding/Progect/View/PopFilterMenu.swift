//
//  PopFilterMenu.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit


/// 筛选 项目视图
class PopFilterMenu: UIView {
    // MARK: - 暴露的属性方法
    var showStatus: Bool = false
    var clickBlock:((_ selectNum: Int) -> ())?
    var closeBlock:(()->())?
    var selectNum: Int = 0
    
    func dismiss() {
        
    }
    
    func show(atView containerView: UIView) {
        containerView.addSubview(self)
        blurView.show(atView: self)
    }
    
    func refreshMenu() {
        
    }
    
    // MARK: - 内部属性
    fileprivate var items = [String]()
    // 背景视图
    fileprivate lazy var blurView: BlurView = {
        let blur = BlurView(frame: self.bounds)
        blur.hasTapGustureEnable = true
        blur.delegate = self
        blur.showDuration = 0.1
        blur.dismissDuration = 0.2
        return blur
    }()
    // tableView
    fileprivate lazy var tableview: UITableView = {
       let tabview = UITableView(frame: self.bounds, style: .plain)
        
        return tabview
    }()

    init(frame: CGRect, items: Array<String>) {
        super.init(frame: frame)
        self.items = items
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopFilterMenu {
    fileprivate func setupUI() {
        backgroundColor = UIColor.clear
        
        
    }
}

extension PopFilterMenu: BlurViewProtocol {
    func willShowBlurView() {
        
    }
    
    func willDismissBlurView() {
        
    }
    
    func didDismissBlurView() {
        
    }
}
