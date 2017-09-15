//
//  UISlider+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation
import UIKit

/// EZSwiftExtensions
private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPod 6 */          "iPod7,1": "iPod Touch 6",
    /* iPhone 4 */        "iPhone3,1": "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",

/* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
/* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
/* iPhone 6 */        "iPhone7,2": "iPhone 6",
/* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
/* iPhone 6S */       "iPhone8,1": "iPhone 6S",
/* iPhone 6S Plus */  "iPhone8,2": "iPhone 6S Plus",
/* iPhone 7 */        "iPhone9,1": "iPhone 7", "iPhone9,3": "iPhone 7",
/* iPhone 7 Plus */   "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus",
/* iPhone SE */       "iPhone8,4": "iPhone SE",

/* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
/* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
/* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
/* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
/* iPad Air 2 */      "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
/* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
/* iPad Mini 2 */     "iPad4,4": "iPad Mini 2", "iPad4,5": "iPad Mini 2", "iPad4,6": "iPad Mini 2",
/* iPad Mini 3 */     "iPad4,7": "iPad Mini 3", "iPad4,8": "iPad Mini 3", "iPad4,9": "iPad Mini 3",
/* iPad Mini 4 */     "iPad5,1": "iPad Mini 4", "iPad5,2": "iPad Mini 4",
/* iPad Pro */        "iPad6,7": "iPad Pro", "iPad6,8": "iPad Pro",
/* AppleTV */         "AppleTV5,3": "AppleTV",
/* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

extension UIDevice {
    /// EZSwiftExtensions
    public class func idForVendor() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
    /// EZSwiftExtensions - Operating system name
    public class func systemName() -> String {
        return UIDevice.current.systemName
    }
    
    /// EZSwiftExtensions - Operating system version
    public class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// EZSwiftExtensions - Operating system version
    public class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }
    
    /// EZSwiftExtensions
    public class func deviceName() -> String {
        return UIDevice.current.name
    }
    
    /// EZSwiftExtensions
    public class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }
    
    /// EZSwiftExtensions
    public class func deviceModelReadable() -> String {
        return DeviceList[deviceModel()] ?? deviceModel()
    }
    
    /// EZSE: Returns true if the device is iPhone //TODO: Add to readme
    public class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    /// EZSE: Returns true if the device is iPad //TODO: Add to readme
    public class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    /// EZSwiftExtensions
    public class func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        var identifier = ""
        let mirror = Mirror(reflecting: machine)
        
        for child in mirror.children {
            let value = child.value
            
            if let value = value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        
        return identifier
    }
    
    //TODO: Fix syntax, add docs and readme for these methods:
    //TODO: Delete isSystemVersionOver()
    // MARK: - Device Version Checks
    
    public enum Versions: Float {
        case five = 5.0
        case six = 6.0
        case seven = 7.0
        case eight = 8.0
        case nine = 9.0
        case ten = 10.0
    }
    
    public class func isVersion(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue && systemFloatVersion() < (version.rawValue + 1.0)
    }
    
    public class func isVersionOrLater(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue
    }
    
    public class func isVersionOrEarlier(_ version: Versions) -> Bool {
        return systemFloatVersion() < (version.rawValue + 1.0)
    }
    
    public class var CURRENT_VERSION: String {
        return "\(systemFloatVersion())"
    }
    
    // MARK: iOS 5 Checks
    
    public class func IS_OS_5() -> Bool {
        return isVersion(.five)
    }
    
    public class func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.five)
    }
    
    public class func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.five)
    }
    
    // MARK: iOS 6 Checks
    
    public class func IS_OS_6() -> Bool {
        return isVersion(.six)
    }
    
    public class func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.six)
    }
    
    public class func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.six)
    }
    
    // MARK: iOS 7 Checks
    
    public class func IS_OS_7() -> Bool {
        return isVersion(.seven)
    }
    
    public class func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.seven)
    }
    
    public class func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.seven)
    }
    
    // MARK: iOS 8 Checks
    
    public class func IS_OS_8() -> Bool {
        return isVersion(.eight)
    }
    
    public class func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.eight)
    }
    
    public class func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.eight)
    }
    
    // MARK: iOS 9 Checks
    
    public class func IS_OS_9() -> Bool {
        return isVersion(.nine)
    }
    
    public class func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.nine)
    }
    
    public class func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.nine)
    }
    
    // MARK: iOS 10 Checks
    
    public class func IS_OS_10() -> Bool {
        return isVersion(.ten)
    }
    
    public class func IS_OS_10_OR_LATER() -> Bool {
        return isVersionOrLater(.ten)
    }
    
    public class func IS_OS_10_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.ten)
    }
    
    /// EZSwiftExtensions
    public class func isSystemVersionOver(_ requiredVersion: String) -> Bool {
        switch systemVersion().compare(requiredVersion, options: NSString.CompareOptions.numeric) {
        case .orderedSame, .orderedDescending:
            //println("iOS >= 8.0")
            return true
        case .orderedAscending:
            //println("iOS < 8.0")
            return false
        }
    }
}


extension UIDevice {
    /// 当前设备的系统版本
    class var currentSystemVersion : String {
        get {
            return UIDevice.current.systemVersion
        }
    }
    
    /// 当前系统的名称
    class var currentSystemName : String {
        get {
            return UIDevice.current.systemName
        }
    }
    
    func maxScreenLength() -> CGFloat {
        let bounds = UIScreen.main.bounds
        return max(bounds.width, bounds.height)
    }
    
    func iPhone4() -> Bool {
        return maxScreenLength() == 480
    }
    
    func iPhone5() -> Bool {
        return maxScreenLength() == 568
    }
    
    func iPhone6or7() -> Bool {
        return maxScreenLength() == 667
    }
    
    func iPhone6or7Plus() -> Bool {
        return maxScreenLength() == 736
    }
    
    
    /// 建议的根据设备获取字体
    ///
    /// - Parameters:
    ///   - size: 字体设计大小
    ///   - q6: 默认系数 0.94
    ///   - q5: 默认系数 0，86
    ///   - q4: 默认系数 0.80
    /// - Returns: 字体大小
    func fontSizeForDevice(_ size: CGFloat, q6: CGFloat = 0.94, q5: CGFloat = 0.86, q4: CGFloat = 0.80) -> CGFloat {
        if iPhone4() {
            return max(10, size * q4)
        } else if iPhone5() {
            return max(10, size * q5)
        } else if iPhone6or7() {
            return max(10, size * q6)
        }
        return size
    }
    
}

/// 建议根据设备获取垂直的间距大小
///
/// - Parameters:
///   - value: 设计大小
///   - q6: 0.9
///   - q5: 0.77
///   - q4: 0.65
/// - Returns: 间距大小
public func suggestedVerticalConstraint(_ value: CGFloat, q6: CGFloat = 0.9, q5: CGFloat = 0.77, q4: CGFloat = 0.65) -> CGFloat {
    if UIDevice.current.iPhone4() {
        return ceil(value * q4)
    } else if UIDevice.current.iPhone5() {
        return ceil(value * q5)
    } else if UIDevice.current.iPhone6or7() {
        return ceil(value * q6)
    } else {
        return value
    }
}

/// 建议根据设备获取平行的间距大小
///
/// - Parameters:
///   - value: 设计大小
///   - q6: 0.9
///   - q5: 0.77
///   - q4: 0.65
public func suggestedHorizontalConstraint(_ value: CGFloat, q6: CGFloat = 0.9, q5: CGFloat = 0.77, q4: CGFloat = 0.77) -> CGFloat {
    if UIDevice.current.iPhone4() {
        return ceil(value * q4)
    } else if UIDevice.current.iPhone5() {
        return ceil(value * q5)
    } else if UIDevice.current.iPhone6or7() {
        return ceil(value * q6)
    } else {
        return value
    }
}


