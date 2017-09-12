//
//  BaseTabBarController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
        
    }


}

// MARK: - 设置界面
extension BaseTabBarController {
    /// 添加所有的控制器
    fileprivate func addChildViewControllers() {
        addChildViewController(vc: ProjectViewController(), title: "项目", imageName: "project_normal", selectedImage:"project_selected")
        addChildViewController(vc: TaskViewController(), title: "任务", imageName: "task_normal", selectedImage:"task_selected")
        addChildViewController(vc: TweetViewController(), title: "冒泡", imageName: "tweet_normal", selectedImage:"tweet_selected")
        addChildViewController(vc: MessageViewController(), title: "消息", imageName: "privatemessage_normal", selectedImage:"privatemessage_selected")
        addChildViewController(vc: ProfileViewController(), title: "我", imageName: "me_normal", selectedImage:"me_selected")
    }
    
    private func addChildViewController(vc: UIViewController, title: String, imageName: String, selectedImage: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        let nav = BaseNavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
}
