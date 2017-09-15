//
//  UILabel+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/11.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit


// MARK: - 初始化
extension UILabel {
    
    
    /// label多行居中
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize , 默认是14号子
    ///   - color: color，默认是深灰色
    ///   - screenInset: 先对与屏幕左右的缩进，默认是0，居中显示，如果设置，则左对齐
    convenience init(title: String,
                     fontSize: CGFloat? = 14,
                     color: UIColor? = UIColor.darkGray,
                     screenInset: CGFloat? = 0
        ) {
        self.init()
        text = title
        //界面设计上，避免使用纯黑色.默认值
        textColor = color
        font = UIFont.sysfont(ofSize: fontSize!)
        numberOfLines = 0
        if screenInset == 0 {
            textAlignment = .center
        } else {
            preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset!
            textAlignment = .left
        }
        sizeToFit()
        
    }
    
    
    /// label初始化
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - size: 尺寸，默认为nil的时候sizeToFite
    ///   - fontSize: 字体尺寸，默认是14
    ///   - color: 颜色，默认是黑色
    ///   - alignment: 默认left
    convenience init(title: String?,
                     frame: CGRect? = nil,
                     fontSize: CGFloat = 14,
                     color: UIColor? = myBlackColr,
                     alignment:NSTextAlignment?) {
        self.init()
        self.text = title
        self.font = UIFont.sysfont(ofSize: fontSize)
        self.textColor = color
        self.textAlignment = alignment ?? .left
        if frame != nil {
            self.frame = frame!
        }else {
            self.sizeToFit()
        }
    }
    
    convenience init(lableText:String) {
        self.init()
        self.text = lableText
    }
    
    /// EZSwiftExtensions: fontSize: 17
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(x: x, y: y, w: w, h: h, fontSize: 17)
    }
    
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, fontSize: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        font = UIFont.HelveticaNeue(type: FontType.None, size: fontSize)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        textAlignment = NSTextAlignment.left
        isUserInteractionEnabled = true
        numberOfLines = 1
    }
    
}

// MARK: - UILabel尺寸修改
extension UILabel {
    
    /// EZSwiftExtensions 预计尺寸
    public func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    
    /// EZSwiftExtensions 预计的高度
    public func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: w, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    /// EZSwiftExtensions 预计的宽度
    public func getEstimatedWidth() -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: h)).width
    }
    
    /// EZSwiftExtensions 适配高度
    public func fitHeight() {
        self.h = getEstimatedHeight()
    }
    
    /// EZSwiftExtensions 适配宽度
    public func fitWidth() {
        self.w = getEstimatedWidth()
    }
    
    /// EZSwiftExtensions 尺寸适配
    public func fitSize() {
        self.fitWidth()
        self.fitHeight()
        sizeToFit()
    }
    
    
    /// 计算尺寸
    ///
    /// - Parameter width: 宽度
    /// - Returns: 尺寸
    func contentSize(width: CGFloat) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        
        let contentFrame = (self.text! as NSString).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSFontAttributeName: self.font], context: nil)
        return contentFrame.size
    }
    
    
    /// UIlabel尺寸
    ///
    /// - Returns: 尺寸
    func contentSize() -> CGSize {
        return contentSize(width: self.width)
    }
    
    /// EZSwiftExtensions (if duration set to 0 animate wont be)
    public func set(text _text: String?, duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
            self.text = _text
        }, completion: nil)
    }
    
    public func font(_ font: CGFloat) {
        self.font = UIFont.sysfont(ofSize: font)
    }
    
}
