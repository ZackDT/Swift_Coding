//
//  String+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 截取字符串
    ///
    /// - Parameter length: 长度
    /// - Returns: 返回从第一位到规定长度的字符串
    func subString(length: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: length)
        return self.substring(to: index)
        
    }
    
    
    
    
}


// MARK: - 字符串高度和尺寸计算
extension String {
    /// 字符串尺寸计算
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - maxWidth: 最大宽度
    /// - Returns: 尺寸
    func size(withFont font: UIFont, maxWidth: CGFloat) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 0
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle] as [String : Any]
        
        let string = self as NSString
        let newSize = string.boundingRect(with: CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                          attributes: attributes,
                                          context: nil).size
        return CGSize.init(width: CGFloat(ceilf(Float(newSize.width))), height: newSize.height)
    }
    
    /// 返回高度
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - width: 宽度
    /// - Returns: 高度
    func renderedHeight(_ font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: 5000)
        let attributes = [NSFontAttributeName: font]
        let objcStr = NSString(string: self)
        let boundingRect = objcStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return boundingRect.height
    }

}


// MARK: - 时间字符串
extension String {
    /// 返回当前日期的描述信息
    /*
     刚刚（一分钟内）
     X分钟前（一小时内）
     X小时前（当天）
     昨天 HH：mm
     MM-dd HH：mm（一年内）
     yyyy-MM-dd HH：MM （更早期）
     
     */
    func dateDescription(date: Date) -> String {
        let calendar = Calendar.current
        //处理今天的日期
        if calendar.isDateInToday(date) {
            let delta = Int(Date().timeIntervalSince(date))
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60)分钟前"
            }
            
            return "\(delta / 3600)小时前"
        }
        var fmt = " HH:mm"
        if calendar.isDateInYesterday(date) {
            return "昨天" + fmt
        }else {
            fmt = "MM-dd" + fmt
            //canlendar.component(.year, from: date)  // 直接获取年的数值
            let comps = calendar.dateComponents([.year], from: date, to: Date())
            if comps.year! > 0 {
                fmt = "yyyy-" + fmt
            }
        }
        
        //根据格式字符串生成描述字符串
        let df = DateFormatter()
        df.locale = Locale(identifier: "en")
        df.dateFormat = fmt
        
        return df.string(from: date)
    }
    
    /// 获取时间
    ///
    /// - Parameter str: 时间格式例如："yyyy-MM-dd HH:mm:ss"
    /// - Returns: date
    func getDate(str: String) -> Date? {
        let dataFormat = DateFormatter()
        dataFormat.dateFormat = str
        dataFormat.locale = Locale.current
        return dataFormat.date(from: self)
    }

}
