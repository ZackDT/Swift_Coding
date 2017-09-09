//
//  BaseViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/8.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    deinit {
        QL1("\(String(describing: self))控制器正常释放")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        QL1("进入\(String(describing: self))控制器---------------")
    }

   

}
