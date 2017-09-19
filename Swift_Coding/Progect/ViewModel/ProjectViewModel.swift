//
//  ProjectViewModel.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/18.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class ProjectViewModel: NSObject {
    var pCount: ProjectCount = ProjectCount()
    var page: Int = 1
    var lists = [ProjectModel]()
    
}

extension ProjectViewModel {
    
    
    /// 请求项目个数
    ///
    /// - Parameter completion: 项目个数模型成功的回调
    func loadProjectCount(completion: @escaping (_ isSuccessed: Bool) -> ()) {
        let url = host + "api/project_count"
        NetworkTools.requestData(.get, URLString: url, parameters: nil) { result in
            guard let resultDict = result as? [String : Any] else { return }
            // 判断数据
            if resultDict["code"] as! Int == 0 {
                QL1(url)
                guard let jsonString = resultDict.formatJSON() else { return }
                if let model = JSONDeserializer<ProjectCount>.deserializeFrom(json: jsonString, designatedPath: "data")  {
                    self.pCount = model
                    completion(true)
                }
                
            }else {
                completion(false)
            }
        }
    }
    
    
    /// 请求项目列表
    ///
    /// - Parameters:
    ///   - typsStr: 类型
    ///   - completion: 完成的回调
    func loadProjects(type typsStr: NSString, completion: @escaping (_ isSuccessed: Bool) -> ()) {
        let url = host + "api/projects"
        let params:[String : String] = ["page": String(self.page), "pageSize": String(99999999), "type": "created"]
        QL1("==================" + url)
        NetworkTools.requestData(.get, URLString: url, parameters: params) { [weak self] result in
            let json = JSON(result)
            // 判断数据
            if json["code"].int == 0 {
                if let string = json["data"]["list"].rawString(){
                    self?.lists = JSONDeserializer<ProjectModel>.deserializeModelArrayFrom(json: string) as! [ProjectModel]
                    completion(true)
                    
                }else {
                    completion(false)
                }
                
            }else {
                completion(false)
            }
        }

    }
    
    
}
