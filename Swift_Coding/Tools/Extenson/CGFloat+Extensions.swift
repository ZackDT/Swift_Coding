//
//  CGFloat+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    /// 返回CGFloat的中心值
    public var center: CGFloat { return (self / 2) }
    
    @available(*, deprecated: 1.8, renamed: "degreesToRadians")
    /// 返回弧度
    public func toRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    /// 返回度数。以度数表示的角度，把数字乘以π/180便转换成弧度
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    /// 返回度数。以度数表示的角度，把数字乘以π/180便转换成弧度
    public mutating func toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }
    
    /// EZSE: 度数到弧度
    public static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    /// EZSE: 弧度到度数
    public func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }
    
    /// EZSE: 把弧度转换成度数
    public mutating func toDegreesInPlace() {
        self = (180.0 * self) / .pi
    }
    
    /// EZSE : 把弧度转换成度数
    public static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }
    
    /// EZSE: Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// EZSE: Returns a random floating point number in the range min...max, inclusive.
    public static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /**
     EZSE :Returns the shortest angle between two angles. The result is always between
     -π and π.
     
     Inspired from : https://github.com/raywenderlich/SKTUtils/blob/master/SKTUtils/CGFloat%2BExtensions.swift
     */
    public static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if angle >= .pi {
            angle -= twoPi
        }
        if angle <= -.pi {
            angle += twoPi
        }
        return angle
    }
}
