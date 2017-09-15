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
    
    fileprivate lazy var myCarousel: iCarousel = {
        let icarousel = iCarousel()
        icarousel.type = .linear
        icarousel.delegate = self
        icarousel.dataSource = self
        icarousel.decelerationRate = 1.0
        icarousel.scrollSpeed = 1.0
        icarousel.isPagingEnabled = true
        icarousel.clipsToBounds = true
        icarousel.bounceDistance = 0.2
        icarousel.isScrollEnabled = false;
        return icarousel
    }()
    
    fileprivate lazy var myPopMenu: PopMenu = {
       let menu = PopMenu(frame: CGRect(x: 0, y: 64, w: kScreenW, h: kScreenH - 64), items: self.menuItems)
        return menu
    }()
    
    fileprivate lazy var menuItems:Array<MenuItem> = [
        MenuItem(title: "项目", iconImage: "pop_Project", glowColor: UIColor.gray, index: 0),
        MenuItem(title: "任务", iconImage: "pop_Task", glowColor: UIColor.gray, index: 1),
        MenuItem(title: "冒泡", iconImage: "pop_Tweet", glowColor: UIColor.gray, index: 2),
        MenuItem(title: "添加好友", iconImage: "pop_User", glowColor: UIColor.gray, index: 3),
        MenuItem(title: "私信", iconImage: "pop_Message", glowColor: UIColor.gray, index: 4),
        MenuItem(title: "两步验证", iconImage: "pop_2FA", glowColor: UIColor.gray, index: 5)
        ]
    
    
}


// MARK: - 设置UI
extension ProjectViewController {
    fileprivate func setupUI() {
        setupNavBtn()
        
        myPopMenu.selectedItemBlock = { [weak self] item in
            self?.myPopMenu.dismiss()
            QL1(item)
        }
        
        view.addSubview(myCarousel)
        myCarousel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, 44, 0))
        }
        
    }
    /// nav
    private func setupNavBtn() {
        self.navigationItem.titleView = self.titleBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addBtn_Nav"), style: .plain, target: self, action: #selector(addItemClick))
    }
    
}

extension ProjectViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return segmentItems.count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let randomV = UIView()
        randomV.backgroundColor = UIColor.random()
        randomV.frame = carousel.bounds
        return randomV
    }
}

// MARK: - 点击事件
extension ProjectViewController {
    func addItemClick() {
        if !myPopMenu.isShowed {
            myPopMenu.show(self.view)
        } else {
            myPopMenu.dismiss()
        }
    }
    
    func fliterClicked(btn: UIButton) {
        QL1("fliterClicked")
    }
}
