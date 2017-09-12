//
//  UISlider+Extensions.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

extension UISlider {
    ///EZSE: Slider moving to value with animation duration
    public func setValue(_ value: Float, duration: Double) {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.setValue(self.value, animated: true)
        }, completion: { (bool) -> Void in
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.setValue(value, animated: true)
            }, completion: nil)
        })
    }
}
