
//
//  LoginHeaderAndFooterView.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import Foundation
import UIKit
import Regex

extension String {
    func urlImageCodePath(_ width: CGFloat) -> String? {
        return urlImageCodePath(UIScreen.main.scale * width, false)
    }
    
    func urlImageCodePath(_ width: CGFloat, _ needCrop: Bool) -> String? {
        var urlString: String = ""
        var canCrop: Bool = false
        guard self.length > 0 else { return nil }
        
        if !hasPrefix("http") {
            //从NSString中获取当中的IP地址使用
            let avatarReg = Regex("/static/fruit_avatar/([a-zA-Z0-9\\-._]+)$")
            let projectReg = Regex("/static/project_icon/([a-zA-Z0-9\\-._]+)$")
            if let imageN = avatarReg.match(self)?.captures[0] {
                urlString = "http://coding-net-avatar.qiniudn.com/\(imageN)?imageMogr2/auto-orient/thumbnail/!\(width)x\(width)r"
                canCrop = true
            }else if let imageN = projectReg.match(self)?.captures[0] {
                urlString = "http://coding-net-avatar.qiniudn.com/\(imageN)?imageMogr2/auto-orient/thumbnail/!\(width)x\(width)r"
                canCrop = true
            }
            if urlString.characters.count <= 0 {
                let path = self.hasPrefix("/") ? (self as NSString).substring(from: 1) : self
                urlString = "\(host)\(path)"
            }
            
        }else {
            return self
        }
        
        if  needCrop && canCrop{
            urlString = urlString.appending("/gravity/Center/crop/\(width)x\(width)")
        }
        
        return urlString
    }

}
