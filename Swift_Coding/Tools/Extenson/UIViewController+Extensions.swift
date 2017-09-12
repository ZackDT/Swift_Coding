//
//  UIViewController+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

// MARK: - Notifications
extension UIViewController {
    
    /*
     open可以被任何人使用，包括override和继承。
     public可以被任何人访问。但其他module中不可以被override和继承，而在module内可以被override和继承。
     */
    /// 增加通知
    open func addNotificationObserver(_ name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    /// 删除通知
    open func removeNotificationObserver(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
    /// 删除通知
    open func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    #if os(iOS)
    ///EZSE: 添加 keyboardWillShowNotification()的通知
    ///
    /// ⚠️ 你也需要实现 ```keyboardWillShowNotification(_ notification: Notification)```
    open func addKeyboardWillShowNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardWillShow.rawValue, selector: #selector(UIViewController.keyboardWillShowNotification(_:)))
    }
    
    ///EZSE:  添加  keyboardDidShowNotification()通知
    ///
    /// ⚠️ 你也需要实现  ```keyboardDidShowNotification(_ notification: Notification)```
    public func addKeyboardDidShowNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidShow.rawValue, selector: #selector(UIViewController.keyboardDidShowNotification(_:)))
    }
    
    ///EZSE:  添加 keyboardWillHideNotification()通知
    ///
    /// ⚠️ 你也需要实现  ```keyboardWillHideNotification(_ notification: Notification)```
    open func addKeyboardWillHideNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardWillHide.rawValue, selector: #selector(UIViewController.keyboardWillHideNotification(_:)))
    }
    
    ///EZSE:  添加keyboardDidHideNotification()通知
    ///
    /// ⚠️ 你也需要实现   ```keyboardDidHideNotification(_ notification: Notification)```
    open func addKeyboardDidHideNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidHide.rawValue, selector: #selector(UIViewController.keyboardDidHideNotification(_:)))
    }
    
    ///  移除通知
    open func removeKeyboardWillShowNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardWillShow.rawValue)
    }
    ///  移除通知
    open func removeKeyboardDidShowNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardDidShow.rawValue)
    }
    ///  移除通知
    open func removeKeyboardWillHideNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardWillHide.rawValue)
    }
    ///  移除通知
    open func removeKeyboardDidHideNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardDidHide.rawValue)
    }
    
    // ==================================
    open func keyboardWillShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillShowWithFrame(frame)
        }
    }
    open func keyboardDidShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidShowWithFrame(frame)
        }
    }
    
    open func keyboardWillHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillHideWithFrame(frame)
        }
    }
    
    open func keyboardDidHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidHideWithFrame(frame)
        }
    }
    
    // ===============自定义用的时候需要覆盖的方法===================
    open func keyboardWillShowWithFrame(_ frame: CGRect) {
        
    }
    
    open func keyboardDidShowWithFrame(_ frame: CGRect) {
        
    }
    
    open func keyboardWillHideWithFrame(_ frame: CGRect) {
        
    }
    
    open func keyboardDidHideWithFrame(_ frame: CGRect) {
        
    }
    
    //EZSE: 使UIViewController注册点击事件，并在ViewController的某处单击时隐藏键盘.
    open func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        /*
         默认为YES,这种情况下当手势识别器识别到touch之后，会发送touchesCancelled给hit-testview以取消hit-test view对touch的响应，这个时候只有手势识别器响应touch。
         
         当设置成NO时，手势识别器识别到touch之后不会发送touchesCancelled给hit-test，这个时候手势识别器和hit-test view均响应touch。
         */
        tap.cancelsTouchesInView = cancelTouches
        view.addGestureRecognizer(tap)
    }
    
    @available(*, deprecated: 1.9)
    public func hideKeyboardWhenTappedAroundAndCancelsTouchesInView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    #endif
    
    
    //EZSE: Dismisses keyboard
    open func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


// MARK: - 一些尺寸扩展
extension UIViewController {
    ///EZSE: Returns maximum y of the ViewController
    open var top: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.top
        }
        if let nav = self.navigationController {
            if nav.isNavigationBarHidden {
                return view.top
            } else {
                return nav.navigationBar.bottom
            }
        } else {
            return view.top
        }
    }
    
    ///EZSE: Returns minimum y of the ViewController
    open var bottom: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.bottom
        }
        if let tab = tabBarController {
            if tab.tabBar.isHidden {
                return view.bottom
            } else {
                return tab.tabBar.top
            }
        } else {
            return view.bottom
        }
    }
    
    ///EZSE: Returns Tab Bar's height
    open var tabBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.tabBarHeight
        }
        if let tab = self.tabBarController {
            return tab.tabBar.frame.size.height
        }
        return 0
    }
    
    ///EZSE: Returns Navigation Bar's height
    open var navigationBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.navigationBarHeight
        }
        if let nav = self.navigationController {
            return nav.navigationBar.h
        }
        return 0
    }
    
    ///EZSE: Returns Navigation Bar's color
    open var navigationBarColor: UIColor? {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarColor
            }
            return navigationController?.navigationBar.tintColor
        } set(value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }
    
    ///EZSE: Returns current Navigation Bar
    open var navBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    /// EZSwiftExtensions
    open var applicationFrame: CGRect {
        return CGRect(x: view.x, y: top, width: view.w, height: bottom - top)
    }
}


// MARK: - VC操作push。pop等
extension UIViewController {
    ///EZSE: 将视图控制器推入接收器的堆栈并更新显示
    open func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    ///EZSE: 从导航堆栈弹出顶视图控制器并更新显示
    open func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    /// EZSE: Hide or show navigation bar
    public var isNavBarHidden:Bool {
        get {
            return (navigationController?.isNavigationBarHidden)!
        }
        set {
            navigationController?.isNavigationBarHidden = newValue
        }
    }
    
    /// EZSE: Added extension for popToRootViewController
    open func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    ///EZSE: 以模态方式呈现视图控制器.
    open func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    open func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }
    ///EZSE: 将指定的视图控制器添加为当前视图控制器的子节点
    open func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        self.addChildViewController(vc)
        toView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    ///EZSE: Adds image named: as a UIImageView in the Background
    open func setBackgroundImage(_ named: String) {
        let image = UIImage(named: named)
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
    
    ///EZSE: 将UIImage作为UIImageView添加到背景 @nonobjc 用来标记oc中不支持的
    @nonobjc func setBackgroundImage(_ image: UIImage) {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
    
    
}


// MARK: - 通知Alert
extension UIViewController {
    
    
    /// 便利初始化
    ///
    /// - Parameter title: 标题
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    /**
     显示alert
     
     - Parameter title:   标题
     - Parameter message: 消息
     - Parameter actions: 动作数组
     */
    func displayAlert(_ title: String?, message: String?, actions: [UIAlertAction]?, preferredStyle: UIAlertControllerStyle = .alert) {
        let alertCtl = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = actions {
            for action in actions {
                alertCtl.addAction(action)
            }
        }else {
            // 默认的按钮
            alertCtl.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        }
        present(alertCtl, animated: true, completion: nil)
    }
    
    /**
     显示alert
     
     - Parameter message: 消息
     - Parameter actions: 动作数组
     */
    func displayAlert(message: String, actions: [UIAlertAction]) {
        displayAlert(nil, message: message, actions: actions)
    }
    
    
    func displayAlert(_ title: String? = nil, message: String, closure: (() -> Void)? = nil) {
        let action = UIAlertAction(title: "确定", style: .cancel) { (action) in
            closure?()
        }
        displayAlert(title, message: message, actions: closure == nil ? nil : [action])
        
    }
    
    
    /// 显示Alert
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    public func showError(_ title: String, message: String? = nil) {
        if !Thread.current.isMainThread {
            DispatchQueue.main.async { [weak self] in
                self?.showError(title, message: message)
            }
            return
        }
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.view.tintColor = UIWindow.appearance().tintColor
        controller.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
}

