//
//  CollectionViewNormalCell.swift
//  DouYuZB
//
//  Created by 刘耀 on 2017/4/12.
//  Copyright © 2017年 深圳多诺信息科技有限公司. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

enum RequestType:Int{
    case FORM = 0
    case JSON
}


/// 网络请求类
class NetworkTools {  //设置单例
    static let sharedInstance = NetworkTools()
    private init() {
        
        
    }
}

var host:String{
    #if DEBUG
        return "https://coding.net/"
    #else
        return "https://coding.net/"
    #endif
}

extension NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                QL4(response.result.error)
                 return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
