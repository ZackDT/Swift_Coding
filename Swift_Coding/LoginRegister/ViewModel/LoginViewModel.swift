//
//  LoginViewModel.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import HandyJSON

class LoginViewModel {
    /// 单利
    static let shared = LoginViewModel()
    
    private init() {
        
    }
    
    /// 创建cellID
    ///
    /// - Parameter type: 类型
    /// - Returns: cellID
    func cellID(_ type: RegisterCellType) -> String {
        return type.rawValue
    }
}

// MARK: - 请求个人数据
extension LoginViewModel {
    func login(_ username: String, _ password: String, _ completion: @escaping (_ isSuccessed: Bool) -> ()) {
        let url = host + "api/v2/account/login"
        let params = ["account": username, "password": password.sha1(),"remember_me":"true"]
        NetworkTools.requestData(.post, URLString: url, parameters: params) { result in
            guard let resultDict = result as? [String : Any] else { return }
            // 判断数据
            if resultDict["code"] as! UInt64 == 0 {
                guard let jsonString = resultDict.formatJSON() else { return }
                if let accountModel = JSONDeserializer<AccountModel>.deserializeFrom(json: jsonString, designatedPath: "data")  {
                    UserDefaults.LoginInfo.set(value: accountModel.global_key, forKey: .token)
                    UserDefaults.LoginInfo.set(value: jsonString, forKey: .userInfo)
                    completion(true)
                }
                
            }else {
                completion(false)
            }
        }
    }
    
    
}
