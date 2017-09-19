//
//  CodingCommon.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/19.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation


/// 获取替代图
///
/// - Parameter width: 宽度 25 33 40 48 50 54 55 80 150
/// - Returns: 图片
public func kPlaceholderImage(with width: Int) -> UIImage? {
    let name = "placeholder_coding_square_" + "\(width)"
    
    let img = UIImage(named: name)
    return img
}


/// 延迟在主线程执行
///
/// - Parameters:
///   - time: 延迟时间
///   - callFunc:   回调
func delay(time: TimeInterval, callFunc: @escaping ()->()) {
    let t = DispatchTime.now() + time
    DispatchQueue.main.asyncAfter(deadline: t) {
        callFunc()
    }
}
