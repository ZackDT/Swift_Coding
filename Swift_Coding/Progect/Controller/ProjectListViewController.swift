//
//  ProjectListViewController.swift
//  Swift_Coding
//
//  Created by Zack on 2017/9/18.
//  Copyright © 2017年 liuyao. All rights reserved.
//

import UIKit

private let projectIdentifier = "projectIdentifier"

/// 项目列表页面
class ProjectListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - 懒加载
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.backgroundColor = UIColor.clear
        tb.dataSource = self
        tb.delegate = self
        tb.separatorStyle = .singleLine
        tb.separatorColor = kColorDDD
        tb.rowHeight = 150
        tb.register(ProjectListCell.self, forCellReuseIdentifier: projectIdentifier)
        return tb
    }()
    fileprivate var refresh: ODRefreshControl!
    fileprivate lazy var projectVM = ProjectViewModel()
}


// MARK: - 设置UI
extension ProjectListViewController {
    fileprivate func setupUI() {
        // tableView
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 44, 0))
        }
        // Refresh
        refresh = ODRefreshControl(in: self.tableView)
        refresh.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        loadData()
    }
}

extension ProjectListViewController {
    @objc fileprivate func loadData() {
        projectVM.loadProjects(type: "") { [weak self] (isSuccess) in
            
            
            self?.refresh.endRefreshing()
        }
        
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProjectListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectIdentifier, for: indexPath) as! ProjectListCell
        cell.textLabel?.text = String(indexPath.row)
        cell.backgroundColor = UIColor.random()
        return cell
    }
}
