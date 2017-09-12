//
//  NotificationCenterTools.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation

public protocol Notifier {
    associatedtype Notification: RawRepresentable
}

public extension Notifier where Notification.RawValue == String {
    
    // MARK: - 静态计算变量
    public static func nameFor(notification: Notification) -> String {
        return "\(self).\(notification.rawValue)"
    }
    
    // MARK: - Instance Methods
    // Pot
    func postNotification(notification: Notification, object: AnyObject? = nil) {
        Self.postNotification(notification, object: object)
    }
    
    func postNotification(notification: Notification, object: AnyObject? = nil, userInfo: [String : AnyObject]? = nil) {
        Self.postNotification(notification, object: object, userInfo: userInfo)
    }
    
    // MARK: - Static Function
    // post
    static func postNotification(_ notification: Notification, object: AnyObject? = nil, userInfo: [String : AnyObject]? = nil) {
        let name = nameFor(notification: notification)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
    }
    // add
    static func addObserver(observer: Any, selector: Selector, notification: Notification, object: Any? = nil) {
        let name = nameFor(notification: notification)
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
    }
    // remove
    static func removeObserver(observer: Any, notification: Notification, object: AnyObject? = nil) {
        let name = nameFor(notification: notification)
        NotificationCenter.default.removeObserver(observer, name:NSNotification.Name(rawValue: name), object:object)
    }
}
