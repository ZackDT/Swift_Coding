//
//  AppDelegate.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupAppearance()
        QorumLogs.enabled = true //打印输出控制
        let sharedIQ = IQKeyboardManager.sharedManager()
        sharedIQ.enable = true
        sharedIQ.enableAutoToolbar = false
        sharedIQ.shouldResignOnTouchOutside = true
        
        Broadcast.addObserver(observer: self, selector: #selector(AppDelegate.switchRootController(notification:)), notification: .changeRootViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UserDefaults.isLogin() ? BaseTabBarController() : IntroductionViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    /// 切换控制器的方法
    func switchRootController(notification: Notification) {
        self.window?.rootViewController = BaseTabBarController()
    }
    
    deinit {
        Broadcast.removeObserver(observer: self, notification: .changeRootViewController)
    }
    
    /// 设置全局外观
    fileprivate func setupAppearance() {
        // UINavigationBar
        let navBar = UINavigationBar.appearance()
        navBar.tintColor = kColorBrandGreen
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: kNavTitleFontSize),NSForegroundColorAttributeName : kColorNavTitle]
        
        // UITabBar
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = kColorBrandGreen
        
        // UITextField  UITextView
        UITextField.appearance().tintColor = kColorBrandGreen//设置UITextField的光标颜色
        UITextView.appearance().tintColor = kColorBrandGreen//设置UITextView的光标颜色
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

