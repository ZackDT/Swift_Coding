//
//  BlurView.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/14.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit


/// 委托
@objc protocol BlurViewProtocol: class {
    @objc optional func willShowBlurView();
    @objc optional func didShowBlurView();
    @objc optional func willDismissBlurView();
    @objc optional func didDismissBlurView();
}

class BlurView: UIView {
    
    enum BlurType: Int {
        // UIToolbar默认的白色
        case `default`
        // UIToolbar的黑色
        case black
        // 半透明白色
        case blackTranslucent
        // 浅白色
        case lightwhite
    }
    
    // MARK: - 暴露的属性和方法
    var blurType: BlurType = .default
    var showed: Bool = false
    var showDuration: Float = 0.3
    var dismissDuration:Float = 0.3
    
    var guestureEnable:Bool = false
    
    weak var delegate: BlurViewProtocol?
    
    var hasTapGustureEnable: Bool {
        set(newValue){
            self.guestureEnable = newValue
            self.setupTapGesture()
        }
        get{
            return self.guestureEnable
        }
    }
    var backgroundView: UIView {
        get{
            switch self.blurType {
            case .default:
                return self.defaultView
            case .black:
                return self.blackView
            case .blackTranslucent:
                return self.blackTranslucentView
            case .lightwhite:
                return self.lightWhitView
            }
        }
    }
    
    func show(atView containerView: UIView) {
        showAnimation(atView: containerView)
    }
    
    func dismiss() {
        hidedenAnimation()
    }
    
    // MARK: - 内部懒加载控件
    fileprivate lazy var defaultView: UIToolbar = {
        let toolbar = UIToolbar(frame:self.bounds)
        toolbar.barStyle = .default
        return toolbar
    }()
    fileprivate lazy var blackView: UIToolbar = {
        let toolbar = UIToolbar(frame:self.bounds)
        toolbar.barStyle = .black
        return toolbar
    }()
    fileprivate lazy var blackTranslucentView: UIToolbar = {
        let toolbar = UIToolbar(frame:self.bounds)
        toolbar.barStyle = .blackTranslucent
        return toolbar
    }()
    fileprivate lazy var lightWhitView: UIView = {
        let view = UIToolbar(frame:self.bounds)
        view.backgroundColor = UIColor(white: 0.2, alpha: 1.0);
        return view
    }()
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //if the super view of current blur view is changed, this method will be called.
    override func willMove(toSuperview newSuperview: UIView?) {
        if(newSuperview != nil){
            let backgroundView = self.backgroundView;
            backgroundView.isUserInteractionEnabled = false;
            self.addSubview(backgroundView);
        }
    }
    

}

extension BlurView {
    fileprivate func setupTapGesture() {
        if self.hasTapGustureEnable {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
            self.addGestureRecognizer(tap)
        }
    }
    
    func handleTapGesture(_ gesture:UIGestureRecognizer) {
        hidedenAnimation()
    }
    
    fileprivate func showAnimation(atView containerView:UIView) {
        if self.showed {
            hidedenAnimation()
        } else {
            self.delegate?.willShowBlurView?()
        }
        
        self.alpha = 0.0
        containerView.insertSubview(self, at: 0)
        UIView.animate(withDuration: Double(self.showDuration), delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1.0
        }) { (finished) in
            self.showed = true
            self.delegate?.didShowBlurView?()
        }
        
    }
    
    fileprivate func hidedenAnimation() {
        self.delegate?.willDismissBlurView?()
        
        UIView.animate(withDuration: Double(self.dismissDuration), delay: 0.3, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.showed = false
            self.delegate?.didDismissBlurView?()
            self.removeFromSuperview()
        }
        
    }
}
