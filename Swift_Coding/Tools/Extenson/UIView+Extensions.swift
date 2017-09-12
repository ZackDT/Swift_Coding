//
//  UIView+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

// MARK: 自定义初始化
extension UIView {
    /// 初始化
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
    
    /// EZSwiftExtensions, puts padding around the view
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.x + padding, y: superView.y + padding, width: superView.w - padding*2, height: superView.h - padding*2))
    }
    
    /// EZSwiftExtensions - Copies size of superview
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

// MARK: - 一些视图操作方法
extension UIView {
    /// 移除所有视图
    func removeAllSubviews() {
        
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    
    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    ///EZSE: 循环，直到找到顶层根视图
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
    
    /// 当前View所在的VC
    var currentViewController: UIViewController? {
        get {
            var superView: UIView? = self
            while superView != nil {
                let nextResponder = superView?.next
                if let vc = nextResponder as? UIViewController {
                    return vc
                }
                superView = superView?.superview
            }
            return nil
        }
    }
    
    /// 重新排序视图
    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
    
    /// 设置视图在父视图的水平中心点
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.x = parentView.w/2 - self.w/2
    }
    /// 设置视图在父视图的垂直中心点
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.y = parentView.h/2 - self.h/2
    }
    
    /// EZSE: 在水平和垂直方向上都水平
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
    
}


// MARK: - 图片
extension UIView {
    
    /// 获取图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 图片
    func imageFrom(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 创建一个快照图像的完整视图层次结构
    ///
    /// - Returns: 图片
    func snapshot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap!
    }
    
    /// EZSwiftExtensions
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


// MARK: - Transform Extensions
extension UIView {
    /// 旋转角度X
    public func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }
    /// 旋转角度Y
    public func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }
    /// 旋转角度Z
    public func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    /// 旋转角度XYZ
    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    /// 缩放视图
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

// MARK: - Layer Extensions
extension UIView {
    //TODO: 圆角
    /// 圆角
    func corner(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    //TODO: 边框
    /// 边框颜色大小
    func border(_ borderWidth: CGFloat,_ borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor;
    }
    /// 边框 颜色大小
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    public func doCircle() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = kColorDDD.cgColor
    }
    public func doNotCircle() {
        self.layer.cornerRadius = 0.0
        self.layer.borderWidth = 0.0
    }
    
    
    
    
    /// 边框 两侧
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    /// 边框 顶部
    public func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }
    /// 边框 底部
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    /// 边框 左部
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    /// 边框 右边
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    //TODO: 设置阴影
    /// 设置阴影
    ///
    /// - Parameters:
    ///   - shadowColor: 阴影颜色
    ///   - offset: 偏移距离
    ///   - radius: 圆角角度
    func layerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.opacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    /// 设置阴影
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    //TODO: 画圆
    /// 圆环
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    /// 实心圆
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5


// MARK: - 动画
extension UIView {
    /// 弹性动画
    public func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    /// 弹性动画
    public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    
    public func animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    public func animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    public func pop() {
        setScale(x: 1.1, y: 1.1)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    public func popBig() {
        setScale(x: 1.25, y: 1.25)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    //EZSE: 反向pop，适合按钮动画
    public func reversePop() {
        setScale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { [weak self] Void in
            self?.setScale(x: 1, y: 1)
        }) { (bool) in }
    }
    
    ///EZSE: 抖动视图  次数.
    public func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100
        
        self.layer.add(anim, forKey: nil)
    }
}

// MARK: - 点击事件
extension UIView {
    /// EZSwiftExtensions
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
