//
//  BaseNavigationController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            var backImage = UIImage(named: "back_green_Nav")
            backImage = backImage?.withRenderingMode(.alwaysOriginal)
            let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
            backBtn.setImage(backImage, for: .normal)
            backBtn.setTitle("返回", for: .normal)
            backBtn.addTarget(self, action: #selector(BaseNavigationController.backBtnClick(sender:)), for: .touchUpInside)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick(sender: UIButton) {
        popViewController(animated: true)
    }

}
