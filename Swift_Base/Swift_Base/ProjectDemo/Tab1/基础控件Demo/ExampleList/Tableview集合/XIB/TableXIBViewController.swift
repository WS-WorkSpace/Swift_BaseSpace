//
//  TableXIBViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/11.
//

import UIKit

class TableXIBViewController: BaseTableViewController {
    lazy var subTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
//        tableView.RD_registerHeaderFooterNib(XIBTableHeaderView.self)
        /*
         xib创建的view直接赋值给tableview.tableHeaderView会出现view填充不满的问题，右边会有留白现象。即使用Masoty约束frame也没有效果。
         原因：xib创建的view直接赋值给tableview.tableHeaderView会造成约束问题不准确。
         解决办法：先代码创建一个空的UIview,比如叫bgview同时设置frame,把tableview.tableHeaderView = bgview.然后在把xib创建的view添加到bgview上即可。
         */
//        let boundle = Bundle.main.loadNibNamed("XIBTableHeaderView", owner: nil)
//        let viewT = boundle?.first as? XIBTableHeaderView
//        viewT?.backgroundColor = .lightGray
//        tableView.tableHeaderView = viewT

        lazy var headerView = XIBTableHeaderView.loadFromNib()
        tableView.tableHeaderView = headerView

        tableView.register(UINib(nibName: "XIBExampleCell", bundle: nil), forCellReuseIdentifier: XIBExampleCell.CellID)
//        tableView.RD_registerNibCell(XIBExampleCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        return tableView
    }()

    private func mConfigTableView() {
        self.view.addSubview(self.subTableView)
        configModelArr = ["label:a", "label:b,label:label:", "label:clabel:clabel:clabel:clabel:c", "d", "e", "f", "label:label:clabel:clabel:clabel:clabel:clabel:clabel:clabel:clabel:clabel:c"]
//        self.tableView.showEmptyDataViewWithType(EmptyDataViewState.StateNetWorkError)

        clickCellBlock = { [weak self] indexPath, _ in
            // OC对象 和 Swift 区别
            let mType: UIViewController.Type = TableXIBViewController.self
            let childVC = mType.init()
            self?.navigationController?.pushViewController(childVC, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle = "TableViw示例1.0"
        self.mConfigTableView()
    }
}

extension TableXIBViewController {
    /// 重写父类代理自定义xib cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIBExampleCell.CellID, for: indexPath) as? XIBExampleCell
        cell?.leftLab.text = configModelArr[indexPath.row]
        cell?.rightImg.image = UIImage(named: "AppIcon-mini") // "APP_NineGridHeadImg"
        cell?.backgroundColor = UIColor.randomColor
        return cell ?? XIBExampleCell()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
