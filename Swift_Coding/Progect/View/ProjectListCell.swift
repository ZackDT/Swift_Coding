//
//  ProjectListCell.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/18.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

private let kIconSize: CGFloat = 80

class ProjectListCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 内部属性
    fileprivate lazy var iconView: UIImageView = {
       let imgV = UIImageView()
        imgV.corner(radius: 2.0)
        return imgV
    }()
    fileprivate lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = kColorDark3
        lb.font(17)
        lb.sizeToFit()
        return lb
    }()
    fileprivate lazy var owerTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = kColorDarkA
        lb.font(15)
        lb.sizeToFit()
        return lb
    }()
    fileprivate lazy var describeLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = kColorDark7
        lb.font(14)
        lb.numberOfLines = 0
        return lb
    }()
    fileprivate lazy var privateIcon: UIImageView = UIImageView(image: UIImage(named: "icon_project_private"))
    fileprivate lazy var pinIcon: UIImageView = UIImageView(image: UIImage(named: "icon_project_cell_setNormal"))
    fileprivate lazy var commonBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_setFrequent"), for: .normal)
        return btn
    }()
}



// MARK: - 设置UI
extension ProjectListCell {
    fileprivate func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(owerTitle)
        contentView.addSubview(describeLabel)
//        contentView.addSubview(privateIcon)
//        contentView.addSubview(pinIcon)
        contentView.addSubview(commonBtn)
        aaddLayout()
    }
    private func aaddLayout() {
        iconView.snp.remakeConstraints { (make) in
            make.top.left.equalTo(kPaddingLeftWidth)
            make.size.equalTo(CGSize(width: kIconSize, height: kIconSize))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp.right).offset(kPaddingLeftWidth)
            make.right.equalTo(-kPaddingLeftWidth)
            make.top.equalTo(self.iconView.snp.top)
        }
        owerTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp.right).offset(kPaddingLeftWidth)
            make.right.equalTo(-kPaddingLeftWidth)
            make.bottom.equalTo(self.iconView.snp.bottom)
        }
        describeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.bottom.equalTo(self.owerTitle.snp.top).offset(-6)
        }
        commonBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-4)
            make.bottom.equalTo(self.iconView.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 35, height: 20))
        }
    }
}

extension ProjectListCell {
    func configCell(with model: ProjectModel) {
        let url = URL(string: (model.icon?.urlImageCodePath(kIconSize))!)
        iconView.kf.setImage(with: url, placeholder: kPlaceholderImage(with: 55))
        titleLabel.text = model.name
        describeLabel.text = model.description
        owerTitle.text = model.owner_user_name
    }
}
