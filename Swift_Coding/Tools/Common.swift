//
//  Common.swift
//  DinoWeiBo
//
//  Created by liu yao on 2017/2/7.
//  Copyright © 2017年 深圳多诺信息科技有限公司. All rights reserved.
//

// 目的： 提供全局共享属性或者方法
import UIKit
import AVFoundation

// MARK: - 全局通知


// MARK: - 常用常数
public let kStatusBarH : CGFloat = 20
public let kNavBarH :CGFloat = 44
public let kNavigationBarH : CGFloat = 44
public let kScreenW: CGFloat = UIScreen.main.bounds.width
public let kScreenH: CGFloat = UIScreen.main.bounds.height
public let kScreen_Width: CGFloat = kScreenW
public let kScreen_Height: CGFloat = kScreenH
public let kTabBarH :CGFloat = 44
public let kMenuViewH : CGFloat = 200
public let kScreen_Bounds:CGRect = UIScreen.main.bounds

public let kPaddingLeftWidth :CGFloat = 15
public let kLoginPaddingLeftWidth :CGFloat = 18
public let kMySegmentControl_Height :CGFloat = 44
public let kMySegmentControlIcon_Height :CGFloat = 70


public let kKeyWindow = UIApplication.shared.keyWindow

public let SCREEN_MAX_LENGTH = max(kScreenW, kScreenH)
public let SCREEN_MIN_LENGTH = min(kScreenW, kScreenH)
public let IS_IPAD: Bool = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
public let IS_IPHONE: Bool = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
public let IS_RETINA = UIScreen.main.scale >= 2.0
public let IS_IPHONE_4_OR_LESS = IS_IPHONE && (SCREEN_MAX_LENGTH < 568)
public let IS_IPHONE_5 = IS_IPHONE && (SCREEN_MAX_LENGTH == 568.0)
public let IS_IPHONE_6 = IS_IPHONE && (SCREEN_MAX_LENGTH == 667.0)
public let IS_IPHONE_6P = IS_IPHONE && (SCREEN_MAX_LENGTH == 736.0)

// MARK: - 字体大小
public let kBackButtonFontSize :CGFloat = 16
public let kNavTitleFontSize :CGFloat = 18



/// 全局的外观设置颜色

public let myBlackColr = UIColor(hex: 0x424243)    //常用的黑色
public let mygrayColor = UIColor(hex: 0xb2b2b2)    //常用的灰色

// MARK: - 颜色
public let kColorNavBG = UIColor(hex: 0xF8F8F8)
public let kColorNavTitle = UIColor(hex: 0x323A45)
public let kColorTableBG = UIColor(hex: 0xFFFFFF)
public let kColorTableSectionBg = UIColor(hex: 0xF2F4F6)
public let kColor222 = UIColor(hex: 0x222222)
public let kColor666 = UIColor(hex: 0x666666)
public let kColor999 = UIColor(hex: 0x999999)
public let kColorDDD = UIColor(hex: 0xDDDDDD)
public let kColorCCC = UIColor(hex: 0xCCCCCC)
public let kColorBrandGreen = UIColor(hex: 0x3BBD79)
public let kColorBrandRed = UIColor(hex: 0xFF5846)

// MARK: - New Color
public let kColorDark3 = UIColor(hex: 0x323A45)
public let kColorDark4 = UIColor(hex: 0x425063)
public let kColorDark7 = UIColor(hex: 0x76808E)
public let kColorDarkA = UIColor(hex: 0xA9B3BE)
public let kColorDarkD = UIColor(hex: 0xD8DDE4)
public let kColorDarkF = UIColor(hex: 0xF2F4F6)
public let kColorWhite = UIColor(hex: 0xFFFFFF)
public let kColorActionGreen = UIColor(hex: 0x2EBE76)
public let kColorActionRed = UIColor(hex: 0xF56061)
public let kColorActionYellow = UIColor(hex: 0xF3C033)


//返回设计尺寸的缩放
public func kScaleDesign(_ width: CGFloat) -> CGFloat {
    return width * (kScreenW/375)
}
public func kScaleDesign_Height(_ height: CGFloat) -> CGFloat {
    return height * (kScreenH/667.0)
}

public let kAppReviewURL: String = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=923676989"
public let kAppUrl: String = "http://itunes.apple.com/app/id923676989"



