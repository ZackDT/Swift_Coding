//
//  TaskViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import Spring

class TaskViewController: BaseViewController {
    var ballView: SpringView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let acbtn = UIButton(title: "动画", fontSize: 15, color: kColor222, imageName: "addBtn_Nav")
        acbtn.addTarget(self, action: #selector(self.ballAnimation2), for: .touchUpInside)
        view.addSubview(acbtn)
        acbtn.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(20)
        }
        
        ballView = SpringView(frame: CGRect(x: kScreenW * 0.5 - 45, y: kScreenH * 0.5 - 45, w: 90, h: 90))
        ballView.backgroundColor = UIColor.red
        view.addSubview(ballView)
    }
    
    func ballAnimation() {
        ballView.force = 1
        ballView.duration = 1
        ballView.delay = 0
        
        ballView.damping = 0.7
        ballView.velocity = 0.7
        ballView.scaleX = 1
        ballView.scaleY = 1
        ballView.x = 0
        ballView.y = 400
        
        ballView.autohide = true
        
        
        ballView.animation = "SlideUp"
        ballView.curve = "EaseOut"
        ballView.animate()
    }
    
    func ballAnimation2() {
     
    }

}
