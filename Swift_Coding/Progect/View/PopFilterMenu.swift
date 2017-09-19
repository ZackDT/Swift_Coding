//
//  PopFilterMenu.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/12.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit
import pop

private let recordIdentifierNormal = "recordIdentifierNormal"
private let recordIdentifierSquare = "recordIdentifierSquare"
private let recordIdentifierLine = "recordIdentifierLine"
/// 筛选 项目视图
class PopFilterMenu: UIView {
    // MARK: - 暴露的属性方法
    var showStatus: Bool = false
    var clickBlock:((_ selectNum: Int) -> ())?
    var closeBlock:(()->())?
    var selectNum: Int = 0
    
    
    func dismiss() {
        blurView.dismiss()
    }
    
    func show(atView containerView: UIView) {
        containerView.addSubview(self)
        blurView.show(atView: self)
    }
    
    func refreshMenu() {
        projectVM.loadProjectCount { [weak self] (isSuccess) in
            if isSuccess {
                self?.tableview.reloadData()
            }
        }
    }
    
    // MARK: - 内部属性
    fileprivate var projectVM: ProjectViewModel = ProjectViewModel()
    fileprivate var items = [ProjectType]()
    // 背景视图
    fileprivate lazy var blurView: BlurView = {
        let blur = BlurView(frame: self.bounds)
        blur.hasTapGustureEnable = true
        blur.delegate = self
        blur.showDuration = 0.1
        blur.dismissDuration = 0.2
        return blur
    }()
    // tableView
    fileprivate lazy var tableview: UITableView = {
        let tb = UITableView(frame: self.bounds, style: .plain)
        tb.backgroundColor = UIColor.clear
        tb.dataSource = self
        tb.delegate = self
        tb.rowHeight = 50
        tb.separatorStyle = .none
        tb.separatorColor = kColorDDD
        tb.register(PopFilterNormalCell.self, forCellReuseIdentifier: recordIdentifierNormal)
        tb.register(PopFilterFooterLine.self, forHeaderFooterViewReuseIdentifier: recordIdentifierLine)
        tb.register(PopFilterPlazaCell.self, forCellReuseIdentifier: recordIdentifierSquare)
        return tb
    }()
    fileprivate lazy var footorView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 380, w: kScreenW, h: kScreenH - 384))
        v.backgroundColor = UIColor.clear
       return v
    }()

    // MARK: - 初始化
    init(frame: CGRect, items: Array<ProjectType>) {
        super.init(frame: frame)
        self.items = items
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopFilterMenu {
    fileprivate func setupUI() {
        backgroundColor = UIColor.clear
        
        self.addSubview(tableview)
        tableview.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
       
        self.addSubview(footorView)
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didClickedContentView))
        footorView.addGestureRecognizer(gesture)
        
    }
    
    func didClickedContentView(){
        blurView.dismiss()
    }
}

extension PopFilterMenu: BlurViewProtocol {
    func willShowBlurView() {
        showStatus = true
        if let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha) {
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            anim.fromValue = 0.0
            anim.toValue = 1.0
            anim.duration = 0.3
            tableview.pop_add(anim, forKey: "fadeOut")
        }
    }
    
    func willDismissBlurView() {
        if let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha) {
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            anim.fromValue = 1.0
            anim.toValue = 0.0
            anim.duration = 0.2
            tableview.pop_add(anim, forKey: "fadein")
        }
    }
    
    func didDismissBlurView() {
        showStatus = false
        self.removeFromSuperview()
    }
}

extension PopFilterMenu: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: recordIdentifierSquare, for: indexPath) as! PopFilterPlazaCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: recordIdentifierNormal, for: indexPath) as! PopFilterNormalCell
            let projectType = self.items[indexPath.row]
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0:
                    cell.titleL.text = projectType.name + "(" + projectVM.pCount.all + ")"
                case 1:
                    cell.titleL.text = projectType.name + "(\(String(describing: projectVM.pCount.created)))"
                case 2:
                    cell.titleL.text = projectType.name + "(\(String(describing: projectVM.pCount.joined)))"
                default: break
                }
            }
            else if indexPath.section == 1 {
                switch indexPath.row {
                case 0:
                    let projectType = self.items[3]
                    cell.titleL.text = projectType.name + "(\(String(describing: projectVM.pCount.watched)))"
                case 1:
                    let projectType = self.items[4]
                    cell.titleL.text = projectType.name + "(\(String(describing: projectVM.pCount.stared)))"
                default: break
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableview.dequeueReusableHeaderFooterView(withIdentifier: recordIdentifierLine) as! PopFilterFooterLine
        
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.01
        }else {
            return 30.5
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectInt = indexPath.row
        if indexPath.section == 1 {
            selectInt = 3 + indexPath.row
        }
        self.clickBlock?(selectInt)
        dismiss()
    }
}


/// 通用cell
class PopFilterNormalCell: UITableViewCell {
    lazy var titleL: UILabel = {
       let label = UILabel()
        label.font(15)
        label.textColor = kColor222
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentView.addSubview(titleL)
        selectionStyle = .none
        titleL.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.right.bottom.equalTo(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// 项目广场cell
class PopFilterPlazaCell: UITableViewCell {
    fileprivate lazy var titleL: UILabel = {
        let label = UILabel()
        label.font(15)
        label.text = "项目广场"
        label.textColor = kColor222
        return label
    }()
    fileprivate lazy var squareIcon:UIImageView = UIImageView(image: UIImage(named: "fliter_square"))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentView.addSubview(squareIcon)
        contentView.addSubview(titleL)
        selectionStyle = .none
        squareIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        titleL.snp.makeConstraints { (make) in
            make.left.equalTo(self.squareIcon.snp.right).offset(10)
            make.top.right.bottom.equalTo(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 横线cell
class PopFilterFooterLine: UITableViewHeaderFooterView {
    lazy var line: UIView = {
        let label = UIView()
        label.backgroundColor = kColorCCC
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = UIColor.clear
        self.backgroundView = backgroundView
        
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


