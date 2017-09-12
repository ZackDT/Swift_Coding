//
//  AccountModel.swift
//  DNTouTiao
//
//  Created by 刘耀 on 2017/7/3.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import HandyJSON

struct AccountModel: HandyJSON {
    var avatar: String?
    var birthday: String?
    var company: String?
    var country: String?
    var created_at: Int64?
    var degree: Int64?
    var email: String?
    var email_validation: Int64?
    var fans_count: Int64?
    var follow: Int64?
    var followed: Int64?
    var follows_count: Int64?
    var global_key: String!
    var gravatar: String?
    var id: Int64?
    var introduction: String?
    var is_member: Int64?
    var is_phone_validated: Int64?
    var job: Int64?
    var last_activity_at: Int64?
    var last_logined_at: Int64?
    var lavatar: String?
    var location: String?
    var name: String?
    var name_pinyin: String?
    var path: String?
    var phone: Int64?
    var phone_country_code: String?
    var phone_validation: Int64?
    var points_left: String?
    var school: String?
    var sex: Int64?
    var slogan: String?
    var status: Int64?
    var tags: String?
    var tags_str: String?
    var tweets_count: Int64?
    var twofa_enabled: Int64?
    var updated_at: Int64?
    var vip: Int64 = 1
    var website: String?
}


/*
 登录之后的数据
 ===========response===========
 api/v2/account/login:
 {
 code = 0;
 data =     {
 avatar = "/static/fruit_avatar/Fruit-13.png";
 birthday = "";
 company = "";
 country = cn;
 "created_at" = 1498444717000;
 degree = 0;
 email = "";
 "email_validation" = 0;
 "fans_count" = 0;
 follow = 0;
 followed = 0;
 "follows_count" = 1;
 "global_key" = ZackTIC;
 gravatar = "";
 id = 504466;
 introduction = "";
 "is_member" = 0;
 "is_phone_validated" = 1;
 job = 0;
 "last_activity_at" = 1499045872738;
 "last_logined_at" = 1499073521136;
 lavatar = "/static/fruit_avatar/Fruit-13.png";
 location = "";
 name = ZackTIC;
 "name_pinyin" = "";
 path = "/u/ZackTIC";
 phone = 17688703445;
 "phone_country_code" = "+86";
 "phone_validation" = 1;
 "points_left" = "0.1";
 school = "";
 sex = 2;
 slogan = "";
 status = 1;
 tags = "";
 "tags_str" = "";
 "tweets_count" = 0;
 "twofa_enabled" = 0;
 "updated_at" = 1499045868000;
 vip = 1;
 website = "";
 };
 }
 
 */
