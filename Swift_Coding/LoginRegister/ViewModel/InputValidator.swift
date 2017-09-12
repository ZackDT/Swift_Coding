//
//  InputValidator.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit


/// 验证输入的类
class InputValidator {

}

extension InputValidator {
    
    /// 验证邮箱
    class func isValidEmail(_ email : String) -> Bool {
        let re = try? NSRegularExpression(
            pattern: "^\\S+@\\S+\\.\\S+$",
            options: [])
        
        if let re = re {
            let range = NSMakeRange(0, email.lengthOfBytes(using: .utf8))
            let result = re.matches(in: email, options: [], range: range)
            return result.count > 0
        }
        
        return false
    }
    
    /// 验证密码
    class func isValidPassword(_ password : String) -> Bool {
        return password.characters.count >= 6
    }
    
    /// 验证用户名
    class func validateUsername(_ username : String) -> Result {
        // 1.判断字符数是否正确
        if username.characters.count < 6 {
            return Result.failure(message: "输入内容不能少于6个字符")
        }
        
        // 2.账号可用
        return Result.success(message: "账号可用")
    }
    
    class func validatePassword(_ password : String) -> Result {
        if password.characters.count < 6 {
            return Result.failure(message: "输入密码不能少于6个字符")
        }
        
        return Result.success(message: "密码可用")
    }
    
    class func validateRepeatPassword(_ password : String, _ repeatPassword : String) -> Result {
        if password == repeatPassword {
            return Result.success(message: "账号&密码一致")
        }
        
        return Result.failure(message: "账号&密码不一致")
    }
}
