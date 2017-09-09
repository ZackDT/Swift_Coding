//
//  Kingfisher+Extension.swift
//  MiaoLive
//
//  Created by 刘耀 on 2017/4/20.
//  Copyright © 2017年 深圳多诺信息科技有限公司. All rights reserved.
//

import UIKit
import Kingfisher


// MARK: - 对KingFisher的扩展
extension UIImageView {
    func setImage(_ URLString : String?, _ placeHolderName : String? = nil) {
        guard let URLString = URLString else {
            return
        }
        
        guard let url = URL(string: URLString) else {
            return
        }
        
        guard let placeHolderName = placeHolderName else {
            kf.setImage(with: url)
            return
        }
        
        kf.setImage(with: url, placeholder : UIImage(named: placeHolderName))
    }
}
