//
//  ProjectModel.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/19.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import HandyJSON

struct ProjectModel: HandyJSON {
    var backend_project_path: String?
    var ssh_url: String?
    var watch_count: Int = 0
    var icon: String?
    var created_at: Double?
    var id: Double?
    var un_read_activities_count: Int = 0
    var is_public: Bool = true
    var fork_count: Int = 0
    var description: String?
    var pin: Bool = false
    var current_user_role_id: Int = 0
    var type: Int = 1
    var recommended: Int = 0
    var https_url: String?
    var forked: Bool = true
    var svn_url: String?
    var owner_user_picture: String?
    var name: String?
    var project_path: String?
    var stared: Bool = false
    var status: Int = 1
    var watched: Bool = false
    var owner_user_home: String?
    var star_count: Int = 0
    var depot_path: String?
    var plan: Int = 1
    var isTeam: Bool = false
    var git_url: String?
    var updated_at: Double = 0
    var groupId: Int = 0
    var max_member: Int = 0
    var owner_id: Double = 0
    var owner_user_name: String?

}

/*
 "backend_project_path" : "\/user\/liuyao441\/project\/Books",
 "ssh_url" : "git@git.coding.net:liuyao441\/Books.git",
 "watch_count" : 0,
 "icon" : "\/static\/project_icon\/scenery-19.png",
 "created_at" : 1480054811000,
 "id" : 637600,
 "un_read_activities_count" : 0,
 "is_public" : true,
 "fork_count" : 18,
 "description" : "好东西收藏，开发文档，编程语言，电子书等等。。。",
 "pin" : false,
 "current_user_role_id" : 0,
 "type" : 1,
 "recommended" : 0,
 "https_url" : "https:\/\/git.coding.net\/liuyao441\/Books.git",
 "forked" : true,
 "svn_url" : "svn+ssh:\/\/svn@svn.coding.net\/liuyao441\/Books",
 "owner_user_picture" : "https:\/\/dn-coding-net-production-static.qbox.me\/2708ab61-ee05-4164-b025-e253a2611049.jpg",
 "name" : "Books",
 "project_path" : "\/u\/liuyao441\/p\/Books",
 "stared" : false,
 "status" : 1,
 "watched" : false,
 "owner_user_home" : "<a href=\"https:\/\/coding.net\/u\/liuyao441\">liuyao441<\/a>",
 "plan" : 1,
 "isTeam" : false,
 "git_url" : "git:\/\/git.coding.net\/liuyao441\/Books.git",
 "updated_at" : 1491790210000,
 "groupId" : 0,
 "max_member" : 20,
 "owner_id" : 201830,
 "owner_user_name" : "liuyao441",
 "star_count" : 0,
 "depot_path" : "\/u\/liuyao441\/p\/Books\/git"
 
 */
