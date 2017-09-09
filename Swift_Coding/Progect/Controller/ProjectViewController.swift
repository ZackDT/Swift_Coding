//
//  ProjectViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

class ProjectViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
       
    }
    
    // MARK: -  懒加载
    fileprivate let segmentItems = ["全部项目", "我创建的", "我参与的", "我关注的","我收藏的"]
    /// titleBtn
    fileprivate lazy var titleBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(kColorNavTitle, for: .normal)
        btn.font(kNavTitleFontSize)
        btn.addTarget(self, action: #selector(fliterClicked(btn:)), for: .touchUpInside)
        btn.rightImg("全部项目", imageW: 12.0, btnH: 30, imageName: "btn_fliter_down")
        return btn
    }()
    
}


// MARK: - 设置UI
extension ProjectViewController {
    fileprivate func setupUI() {
        setupNavBtn()
        
    }
    /// nav
    private func setupNavBtn() {
        self.navigationItem.titleView = self.titleBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addBtn_Nav"), style: .plain, target: self, action: #selector(addItemClick))
    }
    
    

}


// MARK: - 点击事件
extension ProjectViewController {
    func addItemClick() {
        QL1("addItemClick()")
    }
    
    func fliterClicked(btn: UIButton) {
        QL1("fliterClicked")
    }
}
