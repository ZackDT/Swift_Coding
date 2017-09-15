//
//  NotificationCenterTools.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

/**
 在协议/结构体/枚举里面 如果要定义类方法,需要用 static 修饰
 在类里面定义类方法, 这时候用 class 修饰
 */
protocol NibLoadable{
    
}

extension NibLoadable where Self : UIView{
    
    // 不用用class，协议里不可以定义class方法。类方法必须写成静态方法static。结构体、枚举也是一样的
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    
}
