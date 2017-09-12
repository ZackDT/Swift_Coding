//
//  ResultProtocol.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// 用户验证输入的结果
///
/// - success: 成功的消息
/// - failure: 失败的消息
enum Result {
    case success(message : String)
    case failure(message : String)
}

extension Result {
    var textColor : UIColor {
        switch self {
        case .success:
            return UIColor.black
        default:
            return UIColor.red
        }
    }
    
    var description : String {
        switch self {
        case let .success(message):
            return message
        case let .failure(message):
            return message
        }
    }
    
    var isValid : Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}


// MARK: - 扩展
extension Reactive where Base : UITextField {
    var enableResult : UIBindingObserver<Base, Result> {
        return UIBindingObserver(UIElement: base, binding: { (textFiled, result) in
            textFiled.isEnabled = result.isValid
        })
    }
}
