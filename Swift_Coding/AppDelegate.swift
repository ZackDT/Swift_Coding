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
        
        QorumLogs.enabled = true //打印输出控制
        let sharedIQ = IQKeyboardManager.sharedManager()
        sharedIQ.enable = true
        sharedIQ.enableAutoToolbar = false
        sharedIQ.shouldResignOnTouchOutside = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UserDefaults.isLogin() ? BaseTabBarController() : IntroductionViewController()
        
        window?.makeKeyAndVisible()
        
        return true
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

