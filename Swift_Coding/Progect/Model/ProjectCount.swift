//
//  ProjectCount.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/18.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import HandyJSON


/// 项目个数模型
struct ProjectCount: HandyJSON {
    var all: String = "0"
    var archive: String = "0"
    var created: String = "0"
    var joined: String = "0"
    var stared: String = "0"
    var watched: String = "0"
}


/// 筛选的模型类
struct ProjectType {
    var name:String
    var type: String
}


/*
 all = 6;
 archive = 0;
 created = 6;
 joined = 0;
 stared = 4;
 watched = 5;
 */
