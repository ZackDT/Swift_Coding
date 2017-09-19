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
        
        loadData()
        
    }

    // MARK: - 懒加载
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.backgroundColor = UIColor.clear
        tb.dataSource = self
        tb.delegate = self
        tb.separatorStyle = .singleLine
        tb.separatorColor = kColorDDD
        tb.rowHeight = 110
        tb.register(ProjectListCell.self, forCellReuseIdentifier: projectIdentifier)
        return tb
    }()
    fileprivate var refresh: ODRefreshControl!
    fileprivate var projectVM = ProjectViewModel()
    
    func loadData() {
        projectVM.loadProjects(type: "") { [weak self] (isSuccess) in
            if isSuccess {
                self?.tableView.reloadData()
            }
            self?.refresh.endRefreshing()
        }
    }
}


// MARK: - 设置UI
extension ProjectListViewController {
    fileprivate func setupUI() {
        // tableView
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 44, 0))
        }
        // Refresh
        refresh = ODRefreshControl(in: self.tableView)
        refresh.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        
    }
}

extension ProjectListViewController {
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProjectListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectVM.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: projectIdentifier, for: indexPath) as! ProjectListCell
        let model = projectVM.lists[indexPath.row]
        cell.configCell(with: model)
        return cell
    }
}
