//
//  RegisterViewModel.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import RxSwift


/// 注册管理的VM
class RegisterViewModel {
    var username = Variable("")
    var password = Variable("")
    
    var usernameObserable : Observable<Result>
    var passwordObserable : Observable<Result>
    var registerBtnObservable : Observable<Bool>
    
    init() {
        usernameObserable = username.asObservable().map({ (password) -> Result in
            return InputValidator.validateUsername(password)
        })
        passwordObserable = password.asObservable().map({ (inputStr) -> Result in
            return InputValidator.validatePassword(inputStr)
        })
        
        registerBtnObservable = Observable.combineLatest(passwordObserable, usernameObserable, resultSelector: { (username, password) -> Bool in
            return username.isValid && password.isValid
        })
    }
    
    
}
