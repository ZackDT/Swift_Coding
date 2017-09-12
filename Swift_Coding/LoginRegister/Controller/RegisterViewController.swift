//
//  LoginViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/10.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import AVFoundation

enum RegisterType {
    case phone
    case email
}


class RegisterViewController: BaseViewController {
    // MARK: 定义属性
    fileprivate var registerType: RegisterType?
    fileprivate var rv: RegisterViewModel = RegisterViewModel()
    fileprivate var loginVM: LoginViewModel = LoginViewModel.shared
    
    init(type: RegisterType? = .phone) {
        super.init(nibName: nil, bundle: nil)
        self.registerType = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - 懒加载
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = kColorTableSectionBg
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: self.loginVM.cellID(.text))
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: self.loginVM.cellID(.phone))
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: self.loginVM.cellID(.phoneCode))
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: self.loginVM.cellID(.password))
        
        return tableView
    }()
    
    fileprivate lazy var bottomBtn: UIButton = {
        let ttile = self.registerType == RegisterType.email ? "手机号注册" : "邮箱注册"
       let btn = UIButton(title: ttile, fontSize: 15, color: kColorBrandGreen, imageName: nil)
        btn.addTarget(self, action: #selector(changeMethodType), for: .touchUpInside)
        return btn
    }()
    
    
    fileprivate var countryCodeDict:[String: String] = ["country": "China",
                           "country_code": "86",
                           "iso_code": "cn"
                           ]
    fileprivate lazy var footerView: RegisterFooterView = RegisterFooterView()
}

extension RegisterViewController {
    fileprivate func setupUI() {
        title = "注册"
        setupNav()
        setupContent() //tableView
        setupBottomView()
    }
    private func setupNav() {
        if (self.navigationController?.childViewControllers.count)! <= 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(dismissSelf))
        }
    }
    private func setupContent() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = RegisterHeaderView()
        tableView.tableFooterView = footerView
    }
    
    private func setupBottomView() {
        let bottomV = UIView()
        bottomV.backgroundColor = tableView.backgroundColor
        bottomV.addSubview(bottomBtn)
        view.addSubview(bottomV)
        
        bottomV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(55)
        }
        bottomBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomV)
            make.top.equalTo(0)
        }
    }
    
    
}

extension RegisterViewController {
    
}

// MARK: - 点击事件
extension RegisterViewController {
    @objc fileprivate func dismissSelf() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func changeMethodType() {
        if registerType == RegisterType.phone {
            let regVC = RegisterViewController(type: .email)
            navigationController?.pushViewController(regVC, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerType == RegisterType.phone ? 4 : 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier: String!
        
        if registerType == RegisterType.phone {
            cellIdentifier = ( indexPath.row == 3 ? RegisterCellType.phoneCode :
                indexPath.row == 2 ? RegisterCellType.password :
                indexPath.row == 1 ? RegisterCellType.phone :
                RegisterCellType.text ).rawValue
        } else {
            cellIdentifier = (
                indexPath.row == 2 ? RegisterCellType.password :
                indexPath.row == 1 ? RegisterCellType.text :
                RegisterCellType.text ).rawValue
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RegisterTableViewCell
        
        if registerType == RegisterType.phone {
            if indexPath.row == 0 {
                cell.setText(placeholder: " 用户名（个性后缀）", value: "")
            } else if (indexPath.row == 1) {
                cell.setText(placeholder: " 手机号", value: "")
                cell.countryCodeL.text = "+\(countryCodeDict["country_code"]!)"
                
            }else if (indexPath.row == 2) {
                cell.setText(placeholder: " 设置密码", value: "")
            }else if (indexPath.row == 3) {
                cell.setText(placeholder: " 手机验证码", value: "")
            }
        } else {
            if indexPath.row == 0 {
                cell.setText(placeholder: " 用户名（个性后缀）", value: "")
            } else if (indexPath.row == 1) {
                cell.setText(placeholder: " 邮箱", value: "")
                cell.textField.keyboardType = .emailAddress
            }else if (indexPath.row == 2) {
                cell.setText(placeholder: " 设置密码", value: "")
            }
        }
        
        return cell
    }
}
