//
//  UserDefaultTools.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation
import HandyJSON

// MARK: - 扩展
protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue==String {
    /// 关于 String 类型存储和读取
    static func set(value: String, forKey key: defaultKeys) {
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    static func string(forKey key: defaultKeys) -> String? {
        let key = key.rawValue
        return UserDefaults.standard.string(forKey: key)
    }
    
    /// 关于 Int 类型存储和读取
    static func set(value:Int, forKey key:defaultKeys){
        let key = key.rawValue
        UserDefaults.standard.set(value, forKey: key)
    }
    static func integer(forKey key:defaultKeys) -> Int {
        let key = key.rawValue
        return UserDefaults.standard.integer(forKey: key)
    }

    
    static func remove(forKey key: defaultKeys) {
        let key = key.rawValue
        UserDefaults.standard.removeObject(forKey: key)
    }
}


// MARK: - 存储的数据信息
extension UserDefaults {
    /*! 关于账号的信息 Key 都放在这里 */
//    struct AccountInfo: UserDefaultsSettable {
//        enum defaultKeys: String {
//            
//        }
//    }
    
    /*! 关于登陆情况 Key 都放在这里 */
    struct LoginInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case token
            case userInfo
        }
    }
    
    static func isLogin() -> Bool {
        let token = UserDefaults.LoginInfo.string(forKey: .token)
        if token == nil {
            return false
        }else {
            return true
        }
    }
    
    static func userInfo() -> AccountModel? {
        let userInfoStr = UserDefaults.LoginInfo.string(forKey: .userInfo)
        if userInfoStr == nil {
            let accountModel = JSONDeserializer<AccountModel>.deserializeFrom(json: userInfoStr, designatedPath: "data")
            return accountModel
        }else {
            return nil
        }
    }
    
   
}
