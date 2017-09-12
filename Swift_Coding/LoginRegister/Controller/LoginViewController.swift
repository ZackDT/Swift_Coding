//
//  LoginViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.endEditing(true)
    }
    
    // MARK: - 懒加载
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    fileprivate var rv: RegisterViewModel = RegisterViewModel()
    fileprivate var loginVM: LoginViewModel = LoginViewModel.shared
    
    fileprivate lazy var dismissBtn: UIButton = {
        let btn = UIButton(x: 0, y: 20, w: 50, h: 50, target: self, action: #selector(dismissBtnClick))
        btn.setImage(UIImage(named: "dismissBtn_Nav"), for: .normal)
        return btn
    }()
    fileprivate lazy var faBtn: UIButton = {
        let btn = UIButton(x: kScreen_Width - 100, y: 20, w: 100, h: 50, target: self, action: #selector(goto2FAVC))
        btn.setImage(UIImage(named: "twoFABtn_Nav"), for: .normal)
        btn.setTitle(" 两步验证", for: .normal)
        btn.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: self.loginVM.cellID(.text))
        return tableView
    }()
    
    lazy var headerView: LoginHeaderView = LoginHeaderView()
    lazy var footerView: LoginFooterView = LoginFooterView()
    
    lazy var registerBtn: UIButton = {
        let btn = UIButton(x: 0, y: 0, w: 100, h: 30, target: self, action: #selector(registerBtnClick(sender:)))
        btn.setTitle("去注册", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor(white: 1.0, alpha: 0.5), for: .normal)
        btn.setTitleColor(UIColor(white: 0.5, alpha: 0.5), for: .highlighted)
        return btn
    }()

}

// MARK: - 设置UI
extension LoginViewController{
    fileprivate func setupUI() {
        setupBlurView()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        footerView.loginBtn.addTarget(self, action: #selector(logoBtnClick), for: .touchUpInside)
        
        view.addSubview(dismissBtn)
        view.addSubview(faBtn)
        
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(-20)
        }
        
        rv.registerBtnObservable
            .bindTo(footerView.loginBtn.rx.isEnabled)
            .addDisposableTo(bag)

    }
    
    private func setupBlurView() {
        let bgV = UIImageView(frame: self.view.frame)
        bgV.contentMode = .scaleAspectFit
        bgV.image = UIImage(named: "STARTIMAGE.jpg")
        view.addSubview(bgV)
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bgV.bounds
        bgV.addSubview(blurView)
        
    }
}


// MARK: - 点击事件
extension LoginViewController {
    @objc fileprivate func dismissBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    // 去验证
    @objc fileprivate func goto2FAVC() {
        
    }
    // 注册界面
    @objc fileprivate func registerBtnClick(sender: UIButton) {
        
    }
    // 登录
    @objc fileprivate func logoBtnClick() {
        loginVM.login(rv.username.value, rv.password.value) { isSuccess in
            if isSuccess {
                
            }
            
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: loginVM.cellID(.text), for: indexPath) as! RegisterTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.placeholderColor = UIColor.white
        cell.textField.textColor = UIColor.white
        
        if indexPath.item == 0 {
            cell.textField.keyboardType = .emailAddress
            cell.setText(placeholder: " 手机号码/电子邮箱/个性后缀", value:  UserDefaults.LoginInfo.string(forKey: .token))
            cell.textField.rx.text.orEmpty
                .bindTo(rv.username)
                .addDisposableTo(bag)
        }else {
            cell.textField.isSecureTextEntry = true
            cell.setText(placeholder: " 密码", value: "")
            cell.textField.rx.text.orEmpty
                .bindTo(rv.password)
                .addDisposableTo(bag)
        }
        
        return cell
    }
}
