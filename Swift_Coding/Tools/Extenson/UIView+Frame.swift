//
//  String+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

// MARK: - 学习 YYCategirues 的仿写 位置
extension UIView {
    /// EZSwiftExtensions
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    /// EZSwiftExtensions
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    /// EZSwiftExtensions
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    /// EZSwiftExtensions
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    /// View的宽
    var width: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.width = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.width
        }
    }
    /// View的高
    var height: CGFloat {
        set(newValue) {
            var tempRect = self.frame
            tempRect.size.height = newValue
            self.frame = tempRect
        }
        
        get {
            return self.frame.size.height
        }
    }
    /// EZSwiftExtensions
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    /// EZSwiftExtensions
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }
    
    /// EZSwiftExtensions
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    /// EZSwiftExtensions
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }
    
    /// EZSwiftExtensions
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    
    /// EZSwiftExtensions
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    /// EZSwiftExtensions
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    /// EZSwiftExtensions
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
    /// EZSwiftExtensions
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    /// EZSwiftExtensions
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    /// EZSwiftExtensions
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    /// EZSwiftExtensions
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    //TODO: Add to readme
    /// EZSwiftExtensions
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }
}
